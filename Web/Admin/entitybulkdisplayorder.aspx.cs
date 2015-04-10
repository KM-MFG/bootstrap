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
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
	public partial class EntityBulkDisplayOrder : AdminPageBase
	{
		string entityType;

		protected void Page_Load(object sender, EventArgs e)
		{
			entityType = ddEntityType.SelectedValue;

			if(!Page.IsPostBack)
				grdDisplayOrder.DataBind();
		}

		protected void grdDisplayOrder_DataBinding(object sender, EventArgs e)
		{
			using(var dbconn = new SqlConnection(DB.GetDBConn()))
			{
				var sql = string.Format("SELECT '{0}' AS EntityType, {0}ID AS EntityId, dbo.GetMlValue(Name, '{1}') AS Name, DisplayOrder FROM {0} WHERE Parent{0}ID = 0 ORDER BY DisplayOrder, Name",
										entityType,
										LocaleSetting);

				dbconn.Open();
				using(var rs = DB.GetRS(sql, dbconn))
				using(var dt = new DataTable())
				{
					dt.Load(rs);
					grdDisplayOrder.DataSource = dt;
				}
			}
		}

		protected void ddEntityType_SelectedIndexChanged(object sender, EventArgs e)
		{
			grdDisplayOrder.DataBind();
		}

		protected void UpdateDisplayOrder(object sender, EventArgs e)
		{
			try
			{
				foreach(GridViewRow row in grdDisplayOrder.Rows)
				{
					var entityId = grdDisplayOrder.DataKeys[row.DataItemIndex].Value;

					var txtDisplayOrder = (TextBox)row.FindControl("txtDisplayOrder");
					var litEntityId = (Literal)row.FindControl("litEntityId");

					int displayOrderVal;

					if(int.TryParse(txtDisplayOrder.Text, out displayOrderVal))
						DB.ExecuteSQL(String.Format("UPDATE {0} SET DisplayOrder = {1} WHERE {0}ID = {2}", entityType, displayOrderVal, entityId));
				}

				AlertMessageDisplay.PushAlertMessage("admin.orderdetails.UpdateSuccessful".StringResource(), AlertMessage.AlertType.Success);
			}
			catch(Exception exception)
			{
				AlertMessageDisplay.PushAlertMessage(exception.Message, AlertMessage.AlertType.Error);
			}

			grdDisplayOrder.DataBind();
		}
	}
}
