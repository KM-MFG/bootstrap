// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
	public partial class securitylog : AdminPageBase
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Server.ScriptTimeout = 5000000;

			SectionTitle = "Security Log";

			if(!ThisCustomer.IsAdminSuperUser)
			{
				AlertMessage.PushAlertMessage(AppLogic.GetString("admin.securitylog.1", SkinID, LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
				return;
			}

			if(IsPostBack)
				return;

			LoadGridView();
			Security.AgeSecurityLog();
		}

		protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
		{
			if(e.Row.RowType == DataControlRowType.DataRow)
			{
				foreach(TableCell c in e.Row.Cells)
				{
					String DD = c.Text;
					String DDDecrypted = Security.UnmungeString(DD);
					if(DDDecrypted.StartsWith(Security.ro_DecryptFailedPrefix, StringComparison.InvariantCultureIgnoreCase))
					{
						DDDecrypted = c.Text;
					}
					c.Text = DDDecrypted;
					if(c.Text.Length > 70)
					{
						c.Text = CommonLogic.WrapString(c.Text, 70, "<br/>");
					}
				}
			}
		}

		protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			GridView1.PageIndex = e.NewPageIndex;
			GridView1.EditIndex = -1;
			LoadGridView();
		}

		private void LoadGridView()
		{
			using(SqlConnection con = new SqlConnection(DB.GetDBConn()))
			{
				con.Open();
				using(IDataReader rs = DB.GetRS("select SecurityAction Action,Description,ActionDate Date,UpdatedBy CustomerID,c.EMail from SecurityLog with (NOLOCK) left outer join Customer c with (NOLOCK) on SecurityLog.UpdatedBy=c.CustomerID order by ActionDate desc", con))
				{
					using(DataTable dt = new DataTable())
					{
						dt.Load(rs);
						GridView1.DataSource = dt;
						GridView1.DataBind();
					}
				}
			}
		}
	}
}
