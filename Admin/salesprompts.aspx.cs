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
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{

	public partial class salesprompts : AdminPageBase
	{
		protected string selectSQL = "select * from SalesPrompt where deleted=0";

		protected override void OnPreRender(EventArgs e)
		{
			if(pnlAdd.Visible)
				litHeader.Text = "admin.editsalesprompt.CreateSalesPrompt".StringResource();
			else
				litHeader.Text = String.Join(" ", 
					"admin.common.Products".StringResource(), 
					"admin.common.breadcrumbseparator".StringResource(), 
					"admin.menu.salesprompts".StringResource());

			base.OnPreRender(e);
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			if(!IsPostBack)
			{
				//Delete Default
				DB.ExecuteSQL("DELETE FROM SalesPrompt WHERE [Name]='NEW Sales Prompt'");

				ViewState["Sort"] = "Name";
				ViewState["SortOrder"] = "ASC";
				ViewState["SQLString"] = selectSQL;

				ShowAddPanel(false);
			}
			Page.Form.DefaultButton = btnInsert.UniqueID;
		}

		protected void BuildGridData()
		{
			string sql = ViewState["SQLString"].ToString();
			sql += " order by " + ViewState["Sort"].ToString() + " " + ViewState["SortOrder"].ToString();

			using(DataTable dt = new DataTable())
			{
				using(SqlConnection con = new SqlConnection(DB.GetDBConn()))
				{
					con.Open();
					using(IDataReader rs = DB.GetRS(sql, con))
					{
						dt.Load(rs);
					}
				}
				if(dt.Rows.Count > 0)
				{
					dt.Columns.Add("EditName");
					foreach(DataRow dr in dt.Rows)
					{
						dr["EditName"] = AppLogic.GetLocaleEntryFields(dr[2].ToString(), "Name", false, true, true, "Please enter the " + AppLogic.GetString("AppConfig.CategoryPromptSingular", 0, LocaleSetting).ToLowerInvariant() + " name", 100, 25, 0, 0, false);
					}
				}

				gMain.DataSource = dt;
				gMain.DataBind();
			}
		}

		protected void gMain_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
		{
			ViewState["SQLString"] = selectSQL;

			gMain.EditIndex = -1;
			BuildGridData();
		}

		protected void gMain_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			if(e.Row.RowType == DataControlRowType.DataRow)
			{
				LinkButton deleteButton = (LinkButton)e.Row.FindControl("Delete");
				if(deleteButton != null)
					deleteButton.Attributes.Add("onClick", "javascript: return confirm('Confirm Delete?')");

				//Localization
				if((e.Row.RowState == DataControlRowState.Normal) || (e.Row.RowState == DataControlRowState.Alternate))
				{
					e.Row.Cells[1].Text = XmlCommon.GetLocaleEntry(((Literal)e.Row.FindControl("ltName")).Text, LocaleSetting, false);
				}
			}
		}

		protected void gMain_Sorting(object sender, GridViewSortEventArgs e)
		{
			gMain.EditIndex = -1;
			ViewState["Sort"] = e.SortExpression.ToString();
			ViewState["SortOrder"] = (ViewState["SortOrder"].ToString() == "ASC" ? "DESC" : "ASC");
			BuildGridData();
		}

		protected void gMain_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			if(e.CommandName == "DeleteItem")
			{
				gMain.EditIndex = -1;
				int iden = Localization.ParseNativeInt(e.CommandArgument.ToString());
				deleteRow(iden);
			}
		}

		protected void deleteRow(int iden)
		{
			StringBuilder sql = new StringBuilder(2500);
			sql.Append("update salesprompt set deleted=1 where SalesPromptID=" + iden.ToString());
			try
			{
				DB.ExecuteSQL(sql.ToString());
				BuildGridData();
				ctrlAlertMessage.PushAlertMessage("Item Deleted", AlertMessage.AlertType.Success);
			}
			catch(Exception ex)
			{
				throw new Exception("Couldn't update database: " + ex.ToString());
			}
		}

		protected void deleteRowPerm(int iden)
		{
			StringBuilder sql = new StringBuilder(2500);
			sql.Append("DELETE FROM SalesPrompt where SalesPromptID=" + iden.ToString());
			try
			{
				DB.ExecuteSQL(sql.ToString());
				BuildGridData();
				ctrlAlertMessage.PushAlertMessage("Item Deleted", AlertMessage.AlertType.Success);
			}
			catch(Exception ex)
			{
				throw new Exception("Couldn't delete from database: " + ex.ToString());
			}
		}

		protected void gMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			gMain.PageIndex = e.NewPageIndex;
			gMain.EditIndex = -1;
			BuildGridData();
		}

		protected void gMain_RowUpdating(object sender, GridViewUpdateEventArgs e)
		{
			GridViewRow row = gMain.Rows[e.RowIndex];

			if(row != null)
			{
				string iden = row.Cells[0].Text.ToString();
				string name = AppLogic.FormLocaleXml("Name");

				// see if this appconfig already exists:
				int N = DB.GetSqlN("select count(Name) as N from SalesPrompt   with (NOLOCK)  where SalesPromptID <>" + iden + " and lower(Name)=" + DB.SQuote(name.ToLowerInvariant()));
				if(N != 0)
				{
					ctrlAlertMessage.PushAlertMessage("There is already another sales prompt with that name.", AlertMessage.AlertType.Danger);
					return;
				}

				StringBuilder sql = new StringBuilder(2500);

				sql.Append("update salesprompt set ");
				sql.Append("Name=" + DB.SQuote(name));
				sql.Append(" where SalesPromptID=" + iden);

				try
				{
					DB.ExecuteSQL(sql.ToString());
					ctrlAlertMessage.PushAlertMessage("Item updated", AlertMessage.AlertType.Success);
					gMain.EditIndex = -1;
					ViewState["SQLString"] = selectSQL;
					BuildGridData();
				}
				catch(Exception ex)
				{
					throw new Exception("Couldn't update database: " + sql.ToString() + ex.ToString());
				}
			}
		}

		protected void gMain_RowEditing(object sender, GridViewEditEventArgs e)
		{
			gMain.EditIndex = e.NewEditIndex;

			BuildGridData();
		}

		protected void btnInsert_Click(object sender, EventArgs e)
		{
			gMain.EditIndex = -1;
			ShowAddPanel(true);

			ltPrompt.Text = AppLogic.GetLocaleEntryFields("", "Name", false, true, true, "Please enter the Sales Prompt", 400, 25, 0, 0, false);
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			StringBuilder sql = new StringBuilder();

			if(ValidInput())
			{
				string name = AppLogic.FormLocaleXml("Name");

				// ok to add them:
				String NewGUID = DB.GetNewGUID();
				sql.Append("insert into SalesPrompt(SalesPromptGUID,Name) values(");
				sql.Append(DB.SQuote(NewGUID) + ",");
				sql.Append(DB.SQuote(name));
				sql.Append(")");

				try
				{
					DB.ExecuteSQL(sql.ToString());
					ctrlAlertMessage.PushAlertMessage("Sales Prompt added.", AlertMessage.AlertType.Success);
					ShowAddPanel(false);
				}
				catch
				{
					ctrlAlertMessage.PushAlertMessage("Sales Prompt already exists.", AlertMessage.AlertType.Danger);
					ShowAddPanel(true);
				}
			}
			else
			{
				ctrlAlertMessage.PushAlertMessage("Please input all required fields.", AlertMessage.AlertType.Info);
			}
		}

		protected void btnCancel_Click(object sender, EventArgs e)
		{
			ShowAddPanel(false);
		}

		protected bool ValidInput()
		{
			if(AppLogic.FormLocaleXml("Name").Equals("<ml></ml>"))
			{
				return false;
			}

			return true;
		}

		protected void ShowAddPanel(bool showAdd)
		{
			if(showAdd)
			{
				pnlAdd.Visible = true;
				pnlGrid.Visible = false;
			}
			else
			{
				pnlAdd.Visible = false;
				pnlGrid.Visible = true;

				BuildGridData();
			}
		}
	}
}
