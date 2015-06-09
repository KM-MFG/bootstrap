// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{

	public partial class giftcardusage : AdminPageBase
	{
		protected string selectSQL = "select G.*, C.LastName, C.FirstName FROM GiftCardUsage G with (NOLOCK) left outer join Customer C with (NOLOCK) " +
			" on G.UsedByCustomerID=C.CustomerID WHERE G.GiftCardID = " + CommonLogic.QueryStringCanBeDangerousContent("giftcardid");
		int GiftCardID;

		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			Page.Form.DefaultButton = btnUsage.UniqueID;
			Page.Form.DefaultFocus = txtUsage.ClientID;

			GiftCardID = CommonLogic.QueryStringNativeInt("giftcardid");

			if (!IsPostBack)
			{
				ltCard.Text = DB.GetSqlS("SELECT SerialNumber AS S FROM GiftCard WHERE GiftCardID = " + CommonLogic.QueryStringCanBeDangerousContent("giftcardid"));
				ViewState["Sort"] = "G.CreatedOn";
				ViewState["SortOrder"] = "DESC";
				ViewState["SQLString"] = selectSQL;

				EditLink.NavigateUrl = EditLinkBottom.NavigateUrl = String.Format("{0}?giftcardid={1}", AppLogic.AdminLinkUrl("giftcard.aspx"), GiftCardID);

				buildGridData();
			}
		}

		protected void buildGridData()
		{
			string sql = ViewState["SQLString"].ToString();
			sql += " order by " + ViewState["Sort"].ToString() + " " + ViewState["SortOrder"].ToString();

			using (SqlConnection dbconn = DB.dbConn())
			{
				dbconn.Open();
				using (IDataReader rs = DB.GetRS(sql, dbconn))
				{
					using (DataTable dt = new DataTable())
					{
						dt.Load(rs);

						gMain.DataSource = dt;
						gMain.DataBind();
					}
				}
			}
			ltBalance.Text = Localization.CurrencyStringForDisplayWithoutExchangeRate(DB.GetSqlNDecimal("SELECT Balance AS N FROM GiftCard WHERE GiftCardID=" + GiftCardID));
		}

		protected void gMain_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			if (e.Row.RowType == DataControlRowType.DataRow)
			{
				DataRowView myrow = (DataRowView)e.Row.DataItem;

				string amount = Localization.CurrencyStringForDisplayWithoutExchangeRate(Localization.ParseNativeCurrency(myrow["Amount"].ToString()));
				Literal ltAmount = (Literal)e.Row.FindControl("ltAmount");
				ltAmount.Text = amount;
			}
		}
		protected void gMain_Sorting(object sender, GridViewSortEventArgs e)
		{
			ViewState["IsInsert"] = false;
			gMain.EditIndex = -1;
			ViewState["Sort"] = e.SortExpression.ToString();
			ViewState["SortOrder"] = (ViewState["SortOrder"].ToString() == "ASC" ? "DESC" : "ASC");
			buildGridData();
		}

		protected void gMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			ViewState["IsInsert"] = false;
			gMain.PageIndex = e.NewPageIndex;
			gMain.EditIndex = -1;
			buildGridData();
		}
		protected void btnUsage_Click(object sender, EventArgs e)
		{
			StringBuilder sql = new StringBuilder(1024);
			decimal amnt = Localization.ParseUSDecimal(txtUsage.Text);
			int action = Localization.ParseNativeInt(ddUsage.SelectedValue);
			int orderNumber = 0;

			int.TryParse(txtorderNumber.Text.Trim(), out orderNumber);

			string NewGUID = DB.GetNewGUID();
			sql.Append("INSERT INTO GiftCardUsage (GiftCardUsageGUID,GiftCardID,UsageTypeID,UsedByCustomerID,OrderNumber,Amount) VALUES(");
			sql.Append(DB.SQuote(NewGUID) + ",");
			sql.Append(GiftCardID + ",");
			sql.Append(action + ",");
			sql.Append(ThisCustomer.CustomerID + ",");
			sql.Append(orderNumber.ToString() + ",");
			sql.Append(Localization.CurrencyStringForDBWithoutExchangeRate(amnt) + "");

			sql.Append(")");
			DB.ExecuteSQL(sql.ToString());

			//update the gift card
			DB.ExecuteSQL("UPDATE GiftCard SET Balance = Balance" + (action == 3 ? "+" + amnt : "-" + amnt) + " WHERE GiftCardID=" + GiftCardID);

			ViewState["Sort"] = "G.CreatedOn";
			ViewState["SortOrder"] = "DESC";

			buildGridData();
			if (action == 3)
			{
				AlertMessage.PushAlertMessage(AppLogic.GetString("admin.giftcardusage.FundsAdded", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
			}
			else
			{
				AlertMessage.PushAlertMessage(AppLogic.GetString("admin.giftcardusage.FundsDecremented", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
			}

			// reset form fields:
			txtUsage.Text = txtorderNumber.Text = String.Empty;
			ddUsage.SelectedIndex = 0;
		}
	}
}
