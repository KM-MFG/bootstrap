// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.UI.WebControls;
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
	public partial class OrderOption : AdminPageBase
	{
		readonly bool UseHtmlEditor;

		string SelectedLocale
		{
			get { return !string.IsNullOrWhiteSpace(ddLocales.SelectedValue) ? ddLocales.SelectedValue : Localization.GetDefaultLocale(); }
		}

		int RecordId
		{
			get { return (int?)ViewState["RecordId"] ?? CommonLogic.QueryStringNativeInt("optionid"); }
			set { ViewState["RecordId"] = value; }
		}

		public OrderOption()
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

			LoadLocales();
			LoadTaxClasses();
			LoadScript();
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
			if(SaveForm(RecordId))
				Response.Redirect(String.Format("orderoption.aspx?optionid={0}", RecordId));
		}

		protected void btnSaveAndClose_Click(object sender, EventArgs e)
		{
			if(SaveForm(RecordId))
				Response.Redirect(ReturnUrlTracker.GetReturnUrl(), false);
		}

		void LoadForm(int recordId)
		{
			var isNewRecord = recordId != 0;
			if(!isNewRecord)
			{
				litHeader.Text = "admin.editorderoption.CreateOrderOption".StringResource();

				if(!UseHtmlEditor)
				{
					txtDescription.Visible = true;
					radCopy.Visible = false;
				}
			}
			else
			{
				var query = "SELECT * FROM OrderOption WITH (NOLOCK) WHERE OrderOptionID = @OrderOptionID";
				var parameters = new[]
				{
					new SqlParameter("@OrderOptionID", recordId.ToString())
				};

				using(var connection = DB.dbConn())
				{
					connection.Open();
					using(var reader = DB.GetRS(query, parameters, connection))
					{
						if(reader.Read())
						{
							litOrderOptionId.Text = recordId.ToString();
							txtName.Text = DB.RSFieldByLocale(reader, "Name", SelectedLocale);
							txtCost.Text = DB.RSFieldDecimal(reader, "Cost").ToString();
							txtDisplayOrder.Text = DB.RSFieldInt(reader, "DisplayOrder").ToString();
							ddlTaxClass.SelectedValue = DB.RSFieldInt(reader, "TaxClassID").ToString();
							cbxDefaultisChecked.Checked = DB.RSFieldBool(reader, "DefaultIsChecked");

							if(UseHtmlEditor)
							{
								radCopy.Content = DB.RSFieldByLocale(reader, "Description", SelectedLocale);
							}
							else
							{
								txtDescription.Visible = true;
								radCopy.Visible = false;
								txtDescription.Text = DB.RSFieldByLocale(reader, "Description", SelectedLocale);
							}
						}
					}
				}

				ltIcon.Text = "";
				var image1URL = AppLogic.LookupImage("OrderOption", recordId, "icon", 1, ThisCustomer.LocaleSetting);
				if(image1URL.Length != 0)
				{
					if(image1URL.IndexOf("nopicture") == -1)
						ltIcon.Text = String.Format(AppLogic.GetString("admin.common.Clickheretodeleteimage", SkinID, LocaleSetting), "<a href=\"javascript:void(0);\" onClick=\"DeleteImage('~/" + image1URL + "','OrderPic');\">", "</a>") + "<br/>\n";
					
					ltIcon.Text += ("<br/><img id=\"OrderPic\" name=\"OrderPic\" border=\"0\" src=\"" + image1URL + "?" + CommonLogic.GetRandomNumber(1, 1000000).ToString() + "\">\n");
				}

				//Editing Cart Upsell: {0} (ID={1})
				litHeader.Text = String.Format("admin.editorderoption.EditingOrderOption".StringResource(), txtName.Text, recordId);

				StoresMapping.ObjectID = recordId;
				StoresMapping.DataBind();
			}
		}

		bool SaveForm(int recordId)
		{
			var saved = false;
			var editing = recordId != 0;

			try
			{
				var defaultIsChecked = cbxDefaultisChecked.Checked;
				var optionTaxClassId = int.Parse(ddlTaxClass.SelectedValue);

				var optionCost = 0m;
				var parsedCost = 0m;
				if(decimal.TryParse(txtCost.Text.Trim(), out parsedCost))
					optionCost = parsedCost;

				var optionDisplayOrder = 1;
				var parsedDisplayOrder = 0;
				if(int.TryParse(txtDisplayOrder.Text.Trim(), out parsedDisplayOrder))
					optionDisplayOrder = parsedDisplayOrder;

				var optionName = editing
					? AppLogic.FormLocaleXml("Name", txtName.Text.Trim(), SelectedLocale, "orderoption", recordId)
					: AppLogic.FormLocaleXml(txtName.Text.Trim(), SelectedLocale);

				var description = String.Empty;
				if(editing)
				{
					if(UseHtmlEditor)
						description = AppLogic.FormLocaleXml("Description", radCopy.Content, SelectedLocale, "orderoption", recordId);
					else
						description = AppLogic.FormLocaleXmlEditor("Description", "Description", SelectedLocale, "orderoption", recordId);
				}
				else
				{
					if(UseHtmlEditor)
						description = AppLogic.FormLocaleXml(radCopy.Content, SelectedLocale);
					else
						description = AppLogic.FormLocaleXmlEditor("Description", "Description", SelectedLocale, "orderoption", recordId);
				}

				var parameters = new[]
				{
					new SqlParameter("@OrderOptionID", recordId),
					new SqlParameter("@Name", optionName),
					new SqlParameter("@Description", description),
					new SqlParameter("@Cost", optionCost),
					new SqlParameter("@DisplayOrder", optionDisplayOrder),
					new SqlParameter("@DefaultIsChecked", defaultIsChecked),
					new SqlParameter("@TaxClassID", optionTaxClassId)
				};

				var query = editing
					? "UPDATE OrderOption SET Name = @Name, Description = @Description, Cost = @Cost, DisplayOrder = @DisplayOrder, DefaultIsChecked = @DefaultIsChecked, TaxClassID = @TaxClassID WHERE OrderOptionID = @OrderOptionID"
					: "INSERT INTO OrderOption (Name, Description, Cost, DisplayOrder, DefaultIsChecked, TaxClassID) VALUES (@Name, @Description, @Cost, @DisplayOrder, @DefaultIsChecked, @TaxClassID); select cast(SCOPE_IDENTITY() as int) N;";

				var identity = DB.GetSqlN(query, parameters);

				if (!editing)
					RecordId = identity;

				StoresMapping.ObjectID = RecordId;
				StoresMapping.Save();

				SaveIconImage(RecordId);

				saved = true;
				ctlAlertMessage.PushAlertMessage("admin.orderdetails.UpdateSuccessful".StringResource(), AlertMessage.AlertType.Success);
			}
			catch (Exception exception)
			{
				ctlAlertMessage.PushAlertMessage(exception.Message, AlertMessage.AlertType.Error);
			}

			return saved;
		}

		void SaveIconImage(int orderOptionId)
		{
			var image1 = String.Empty;
			var image1File = fuIcon.PostedFile;
			if(image1File.ContentLength != 0)
			{
				try
				{
					File.Delete(AppLogic.GetImagePath("OrderOption", "icon", true) + orderOptionId.ToString() + ".jpg");
					File.Delete(AppLogic.GetImagePath("OrderOption", "icon", true) + orderOptionId.ToString() + ".gif");
					File.Delete(AppLogic.GetImagePath("OrderOption", "icon", true) + orderOptionId.ToString() + ".png");
				}
				catch
				{ }

				switch(image1File.ContentType)
				{
					case "image/gif":
						image1 = AppLogic.GetImagePath("OrderOption", "icon", true) + orderOptionId.ToString() + ".gif";
						image1File.SaveAs(image1);
						break;
					case "image/x-png":
					case "image/png":
						image1 = AppLogic.GetImagePath("OrderOption", "icon", true) + orderOptionId.ToString() + ".png";
						image1File.SaveAs(image1);
						break;
					case "image/jpg":
					case "image/jpeg":
					case "image/pjpeg":
						image1 = AppLogic.GetImagePath("OrderOption", "icon", true) + orderOptionId.ToString() + ".jpg";
						image1File.SaveAs(image1);
						break;
				}
			}
		}

		void LoadTaxClasses()
		{
			ddlTaxClass.Items.Clear();

			using(var connection = DB.dbConn())
			{
				connection.Open();
				using(var reader = DB.GetRS("SELECT * FROM TaxClass WITH (NOLOCK) ORDER BY DisplayOrder,Name", connection))
					while(reader.Read())
						ddlTaxClass.Items.Add(new ListItem(DB.RSFieldByLocale(reader, "Name", LocaleSetting), DB.RSFieldInt(reader, "TaxClassID").ToString()));
			}
		}

		void LoadScript()
		{
			var script = new StringBuilder();
			script.Append("function DeleteImage(imgurl,name) {");
			script.Append("window.open('" + AppLogic.AdminLinkUrl("deleteimage.aspx") + "?imgurl=' + imgurl + '&FormImageName=' + name,\"AspDotNetStorefrontAdmin_ML\",\"height=250,width=440,top=10,left=20,status=no,toolbar=no,menubar=no,scrollbars=yes,location=no\")\n");
			script.Append("}");

			var cs = Page.ClientScript;
			cs.RegisterClientScriptBlock(this.Page.GetType(), Guid.NewGuid().ToString(), script.ToString(), true);
		}

		void LoadLocales()
		{
			ddLocales.Items.Clear();

			try
			{
				var localeCount = DB.GetSqlN("select count(Name) as N from LocaleSetting with (NOLOCK)");
				if(localeCount > 1)
					pnlLocale.Visible = true;

				using(var connection = new SqlConnection(DB.GetDBConn()))
				{
					connection.Open();
					using(IDataReader localeReader = DB.GetRS("SELECT Name, Description FROM LocaleSetting  with (NOLOCK)  ORDER BY DisplayOrder,Name", connection))
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
