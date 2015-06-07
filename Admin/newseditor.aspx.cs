// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Web;
using System.Web.UI.WebControls;

namespace AspDotNetStorefrontAdmin
{
	public partial class NewsEditor : AdminPageBase
	{
		readonly bool UseHtmlEditor;

		string SelectedLocale
		{
			get { return !string.IsNullOrWhiteSpace(ddLocales.SelectedValue) ? ddLocales.SelectedValue : Localization.GetDefaultLocale(); }
		}

		int RecordId
		{
			get { return (int?)ViewState["RecordId"] ?? CommonLogic.QueryStringNativeInt("NewsId"); }
			set { ViewState["RecordId"] = value; }
		}

		public NewsEditor()
		{
			UseHtmlEditor = !AppLogic.AppConfigBool("TurnOffHtmlEditorInAdminSite");
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			if(Page.IsPostBack)
				return;

			txtDate.Culture = Thread.CurrentThread.CurrentUICulture;

			LoadLocales();
			LoadForm(RecordId);
		}

		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);

			btnClose.DataBind();
			btnCloseTop.DataBind();
		}

		protected void ddLocales_SelectedIndexChanged(object sender, EventArgs e)
		{
			LoadForm(RecordId);
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			try
			{
				RecordId = SaveForm(RecordId);
				ctlAlertMessage.PushAlertMessage("admin.orderdetails.UpdateSuccessful".StringResource(), AlertMessage.AlertType.Success);
			}
			catch(Exception exception)
			{
				ctlAlertMessage.PushAlertMessage(exception.Message, AlertMessage.AlertType.Error);
			}
		}
		
		protected void btnSaveAndClose_Click(object sender, EventArgs e)
		{
			try
			{
                if (Page.IsValid)
                {
                    SaveForm(RecordId);
                    Response.Redirect(ReturnUrlTracker.GetReturnUrl(), false);
                    return;
                }				
			}
			catch(Exception exception)
			{
				ctlAlertMessage.PushAlertMessage(exception.Message, AlertMessage.AlertType.Error);
			}
		}

		void LoadForm(int recordId)
		{
			var isNewRecord = recordId != 0;
			if(!isNewRecord)
			{
				Title = HeaderText.Text = AppLogic.GetString("admin.editnews.AddingNews", ThisCustomer.LocaleSetting);

				if(!UseHtmlEditor)
				{
					txtCopy.Visible = true;
					radCopy.Visible = false;
				}

				txtDate.SelectedDate = System.DateTime.Now.AddMonths(1);
			}
			else
			{
				Title = HeaderText.Text = AppLogic.GetString("admin.editnews.EditingNews", ThisCustomer.LocaleSetting);

				var query = "SELECT * FROM News WITH (NOLOCK) WHERE NewsID = @NewsID";
				var parameters = new []
				{
					new SqlParameter("@NewsID", recordId.ToString()) 
				};

				using(var connection = DB.dbConn())
				{
					connection.Open();
					using(var reader = DB.GetRS(query, parameters, connection))
					{
						if(reader.Read())
						{
							litNewsId.Text = recordId.ToString();
							txtHeadline.Text = DB.RSFieldByLocale(reader, "Headline", SelectedLocale);

							if(UseHtmlEditor)
							{
								radCopy.Content = DB.RSFieldByLocale(reader, "NewsCopy", SelectedLocale);
							}
							else
							{
								txtCopy.Visible = true;
								radCopy.Visible = false;
								txtCopy.Text = DB.RSFieldByLocale(reader, "NewsCopy", SelectedLocale);
							}

							txtDate.SelectedDate = DB.RSFieldDateTime(reader, "ExpiresOn");
							cbxPublished.Checked = DB.RSFieldBool(reader, "Published");
						}
					}
				}
			}

			StoresMapping.ObjectID = recordId;
			StoresMapping.DataBind();

			if(StoresMapping.StoreCount > 1)
				divStoreMapping.Visible = true;
		}

		int SaveForm(int recordId)
		{
			var editing = recordId != 0;
			var published = cbxPublished.Checked;

			var expirationDate = (DateTime)txtDate.SelectedDate;

			if(expirationDate == System.DateTime.MinValue)
				expirationDate = System.DateTime.Now.AddMonths(1);

			var headline = editing
				? AppLogic.FormLocaleXml("Headline", txtHeadline.Text.Trim(), SelectedLocale, "news", recordId)
                : AppLogic.FormLocaleXml(txtHeadline.Text.Trim(), SelectedLocale);

			var copy = String.Empty;
			if(editing)
				copy = UseHtmlEditor
					? AppLogic.FormLocaleXml("NewsCopy", radCopy.Content, SelectedLocale, "news", recordId)
					: AppLogic.FormLocaleXmlEditor("NewsCopy", "NewsCopy", SelectedLocale, "news", recordId);
			else
				copy = UseHtmlEditor
					? AppLogic.FormLocaleXml(radCopy.Content, SelectedLocale)
					: AppLogic.FormLocaleXmlEditor("NewsCopy", "NewsCopy", SelectedLocale, "news", recordId);

			var identityParam = new SqlParameter
			{
				ParameterName = "identity",
				Direction = ParameterDirection.Output
			};

			var parameters = new[]
			{
				new SqlParameter("@NewsID", recordId),
				new SqlParameter("@Headline", headline),
				new SqlParameter("@Copy", copy),
				new SqlParameter("@ExpirationDate", expirationDate),
				new SqlParameter("@Published", published)
			};

			var query = editing
				? "UPDATE News SET Headline = @Headline, NewsCopy = @Copy, Published = @Published, ExpiresOn = @ExpirationDate WHERE NewsID = @NewsID"
				: "INSERT INTO News (Headline, NewsCopy, Published, ExpiresOn) VALUES (@Headline, @Copy, @Published, @ExpirationDate); select cast(SCOPE_IDENTITY() as int) N;";

			var identity = DB.GetSqlN(query, parameters);
			if(!editing)
				recordId = identity;

			StoresMapping.ObjectID = recordId;
			StoresMapping.Save();

			return recordId;
		}

		void LoadLocales()
		{
			ddLocales.Items.Clear();

			try
			{
				var localeCount = DB.GetSqlN("select count(Name) as N from LocaleSetting with (NOLOCK)");
				if(localeCount > 1)
					pnlLocale.Visible = true;

				using(SqlConnection conn = new SqlConnection(DB.GetDBConn()))
				{
					conn.Open();
					using(IDataReader localeReader = DB.GetRS("SELECT Name, Description FROM LocaleSetting  with (NOLOCK)  ORDER BY DisplayOrder,Name", conn))
					{
						while(localeReader.Read())
						{
							ddLocales.Items.Add(new ListItem(DB.RSField(localeReader, "Description"), DB.RSField(localeReader, "Name")));
						}
					}
				}
			}
			catch(Exception ex)
			{
				ctlAlertMessage.PushAlertMessage(ex.ToString(), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}
		}

	}
}
