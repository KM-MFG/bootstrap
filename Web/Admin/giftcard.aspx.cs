// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using AspDotNetStorefrontCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading;

namespace AspDotNetStorefrontAdmin
{
	public partial class giftcard : AdminPageBase
	{
		protected string selectSQL = "SELECT G.*, C.FirstName, C.LastName from GiftCard G with (NOLOCK) LEFT OUTER JOIN Customer C with (NOLOCK) ON G.PurchasedByCustomerID = C.CustomerID ";
		Customer cust;
		int GiftCardID;

		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			cust = ((AspDotNetStorefrontPrincipal)Context.User).ThisCustomer;
			GiftCardID = CommonLogic.QueryStringNativeInt("giftcardid");
			lnkUsage.NavigateUrl = "" + AppLogic.AdminLinkUrl("giftcardusage.aspx") + "?giftcardid=" + GiftCardID;

			if(GiftCardID == 0)
			{
				OrderNumberRow.Visible = false;
				RemainingBalanceRow.Visible = false;
				ltAmount.Visible = false;
				PurchasedByCustomerIDLiteralRow.Visible = false;
				GiftCardTypeDisplayRow.Visible = false;
				InitialAmountLiteralRow.Visible = false;
				PurchasedByCustomerIDTextRow.Visible = true;
				reqCustEmail.Enabled = true;
			}
			else
			{
				txtAmount.Visible = false; // cannot change after first created
				PurchasedByCustomerIDTextRow.Visible = false;
				reqCustEmail.Enabled = false;
				GiftCardTypeSelectRow.Visible = false;
				InitialAmountTextRow.Visible = false;
			}

			if(!IsPostBack)
			{
				txtDate.Culture = Thread.CurrentThread.CurrentUICulture;

				trEmail.Visible = GiftCardID == 0;

				if(GiftCardID > 0)
				{
					ltCard.Text = DB.GetSqlS("SELECT SerialNumber AS S FROM GiftCard with (NOLOCK) WHERE GiftCardID=" + CommonLogic.QueryStringCanBeDangerousContent("giftcardid"));

					LoadData();

					if(etsMapper.ObjectID != GiftCardID)
					{
						etsMapper.ObjectID = GiftCardID;
						etsMapper.DataBind();
					}
				}
				else
				{
					lblAction.Visible = false;
					rblAction.Visible = false;
					ltCurrentBalance.Text = "NA";
					
					ltCard.Text = AppLogic.GetString("admin.editgiftcard.NewGiftCard", SkinID, LocaleSetting);
					rblAction.SelectedIndex = 0;

					XmlPackage2 iData = new XmlPackage2("giftcardassignment.xml.config");
					System.Xml.XmlDocument xd = iData.XmlDataDocument;
					txtSerial.Text = xd.SelectSingleNode("/root/GiftCardAssignment/row/CardNumber").InnerText;
					txtDate.SelectedDate = DateTime.Now.AddYears(1);
				}
			}

			litStoreMapper.Visible = etsMapper.StoreCount > 1;
			litStoreMapperHdr.Visible = etsMapper.StoreCount > 1;
		}

		protected override void OnPreRender(EventArgs e)
		{
			DataBind();

			base.OnPreRender(e);
		}

		protected void LoadData()
		{
			using(SqlConnection dbconn = DB.dbConn())
			{
				dbconn.Open();
				using(IDataReader rs = DB.GetRS("SELECT * FROM GiftCard  with (NOLOCK)  WHERE GiftCardID=" + GiftCardID, dbconn))
				{
					if(!rs.Read())
					{
						rs.Close();
						AlertMessage.PushAlertMessage("Unable to retrieve data.", AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
						return;
					}

					txtSerial.Text = Server.HtmlEncode(DB.RSField(rs, "SerialNumber"));
					int gcCustomerId = DB.RSFieldInt(rs, "PurchasedByCustomerID");
					ltCustomerID.Text = gcCustomerId.ToString();

					if(gcCustomerId != 0)
					{
						Customer gcCustomer = new Customer(gcCustomerId);
						ltCustomerEmail.Text = gcCustomer.EMail;
					}
					else
					{
						ltCustomerEmail.Text = AppLogic.GetString("admin.editgiftcard.NACustomer", SkinID, LocaleSetting);
					}

					txtOrder.Text = Server.HtmlEncode(DB.RSFieldInt(rs, "OrderNumber").ToString());
					txtDate.SelectedDate = DB.RSFieldDateTime(rs, "ExpirationDate");

					txtAmount.Text = Localization.CurrencyStringForDBWithoutExchangeRate(DB.RSFieldDecimal(rs, "InitialAmount"));
					ltAmount.Text = Localization.CurrencyStringForDBWithoutExchangeRate(DB.RSFieldDecimal(rs, "InitialAmount"));
					ltCurrentBalance.Text = Localization.CurrencyStringForDBWithoutExchangeRate(DB.RSFieldDecimal(rs, "Balance"));

					var giftCardTypeId = DB.RSFieldInt(rs, "GiftCardTypeID");
					var giftCardType = (GiftCardTypes)giftCardTypeId;

					ddType.Items.FindByValue(giftCardTypeId.ToString()).Selected = true;
					ltGiftCardType.Text = giftCardType.ToString();

					rblAction.ClearSelection();
					rblAction.SelectedIndex = CommonLogic.IIF(DB.RSFieldBool(rs, "DisabledByAdministrator"), 1, 0);
				}
			}
		}

		protected void btnClose_Click(object sender, EventArgs e)
		{
			if(SaveForm())
				Response.Redirect(ReturnUrlTracker.GetReturnUrl());
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			if(SaveForm())
				Response.Redirect(String.Format("giftcard.aspx?giftcardid={0}", GiftCardID));
		}

		private bool SaveForm()
		{
			if(Page.IsValid)
			{
				StringBuilder sql = new StringBuilder(1024);

				//validate for the email type on insert for emailing
				int type = Localization.ParseNativeInt(ddType.SelectedValue);
				if((type == 101) && (GiftCardID == 0))
				{
					if((txtEmailBody.Text.Length == 0) || (txtEmailName.Text.Length == 0) || (txtEmailTo.Text.Length == 0))
					{
						AlertMessage.PushAlertMessage(AppLogic.GetString("admin.editgiftcard.EnterEmailPreferences", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
						return false;
					}
				}
				//validate customer id if creating giftcard  (ID = 0 is new giftcard)
				int customerId = Localization.ParseNativeInt(hdnCustomerId.Value);
				if(GiftCardID == 0 && customerId == 0)
				{
					AlertMessage.PushAlertMessage(AppLogic.GetString("admin.editgiftcard.InvalidEmail", cust.SkinID, cust.LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
					return false;
				}

				//make sure the customer has set up their email properly
				if(type == 101 && GiftCardID == 0 && (AppLogic.AppConfig("MailMe_Server").Length == 0 || AppLogic.AppConfig("MailMe_FromAddress") == "sales@yourdomain.com"))
				{
					//Customer has not configured their MailMe AppConfigs yet
					AlertMessage.PushAlertMessage(AppLogic.GetString("giftcard.email.error.2", cust.SkinID, cust.LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
					return false;
				}

				//make sure the date is filled in
				if(txtDate.SelectedDate == null)
				{
					AlertMessage.PushAlertMessage(AppLogic.GetString("admin.common.FillinExpirationDate", cust.SkinID, cust.LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
					return false;
				}

				if(GiftCardID == 0)
				{
					//insert a new card

					//check if valid SN
					int N = DB.GetSqlN("select count(GiftCardID) as N from GiftCard   with (NOLOCK)  where lower(SerialNumber)=" + DB.SQuote(txtSerial.Text.ToLowerInvariant().Trim()));
					if(N != 0)
					{
						AlertMessage.PushAlertMessage(AppLogic.GetString("admin.editgiftcard.ExistingGiftCard", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
						return false;
					}

					//ok to add them
					GiftCard card = GiftCard.CreateGiftCard(customerId,
										txtSerial.Text,
										Localization.ParseNativeInt(txtOrder.Text),
										0,
										0,
										0,
										Localization.ParseNativeDecimal(txtAmount.Text),
										txtDate.SelectedDate.Value,
										Localization.ParseNativeDecimal(txtAmount.Text),
										ddType.SelectedValue,
										CommonLogic.Left(txtEmailName.Text, 100),
										CommonLogic.Left(txtEmailTo.Text, 100),
										txtEmailBody.Text,
										null,
										null,
										null,
										null,
										null,
										null);
					GiftCardID = card.GiftCardID;

					try
					{
						card.SendGiftCardEmail();
					}
					catch
					{
						//reload page, but inform the admin the the email could not be sent
						AlertMessage.PushAlertMessage(AppLogic.GetString("giftcard.email.error.1", cust.SkinID, cust.LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
					}

					//reload page
					etsMapper.ObjectID = GiftCardID;
					AlertMessage.PushAlertMessage(AppLogic.GetString("admin.editgiftcard.GiftCardAdded", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
				}
				else
				{
					//update existing card

					//check if valid SN
					int N = DB.GetSqlN("select count(GiftCardID) as N from GiftCard   with (NOLOCK)  where GiftCardID<>" + GiftCardID.ToString() + " and lower(SerialNumber)=" + DB.SQuote(txtSerial.Text.ToLowerInvariant().Trim()));
					if(N != 0)
					{
						AlertMessage.PushAlertMessage(AppLogic.GetString("admin.editgiftcard.ExistingGiftCard", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
						return false;
					}

					//ok to update
					sql.Append("UPDATE GiftCard SET ");
					sql.Append("SerialNumber=" + DB.SQuote(txtSerial.Text) + ",");
					sql.Append("ExpirationDate=" + DB.SQuote(Localization.ToDBShortDateString(Localization.ParseNativeDateTime(txtDate.SelectedDate.Value.ToString()))) + ",");
					sql.Append("DisabledByAdministrator=" + Localization.ParseNativeInt(rblAction.SelectedValue));
					sql.Append(" WHERE GiftCardID=" + GiftCardID);
					DB.ExecuteSQL(sql.ToString());

					etsMapper.ObjectID = GiftCardID;
					AlertMessage.PushAlertMessage(AppLogic.GetString("admin.editgiftcard.GiftCardUpdated", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
				}
				etsMapper.Save();
			}
			return true;
		}

		[System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
		public static string[] GetCompletionList(string prefixText, int count, string contextKey)
		{
			using(SqlConnection dbconn = DB.dbConn())
			{
				dbconn.Open();
				SqlParameter[] spa = { new SqlParameter("@prefixText", prefixText + '%'), new SqlParameter("@count", count) };
				using(IDataReader rsCustomer = DB.GetRS("SELECT TOP (@count) CustomerId, Email FROM Customer with (NOLOCK) where Email <> '' AND Email like @prefixText OR FirstName like @prefixText OR LastName like @prefixText ORDER BY CustomerId", spa, dbconn))
				{
					IList<string> txtCustomers = new List<string>();
					String customerItem;

					using(DataTable dtCustomer = new DataTable())
					{
						dtCustomer.Columns.Add("CustomerId");
						dtCustomer.Columns.Add("Email");
						dtCustomer.Load(rsCustomer);
						foreach(DataRow row in dtCustomer.Rows)
						{
							customerItem = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(DB.RowField(row, "Email"), DB.RowField(row, "CustomerID"));
							txtCustomers.Add(customerItem);
						}
						return txtCustomers.ToArray();
					}
				}
			}
		}
	}
}
