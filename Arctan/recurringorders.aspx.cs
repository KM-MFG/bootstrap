// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontGateways.Processors;

namespace AspDotNetStorefrontAdmin
{
    /// <summary>
    /// Summary description for recurringorders.
    /// </summary>
    public partial class recurringorders : AdminPageBase
    {
		// NOTE: THIS PAGE DOES NOT PROCESS GATEWAY AUTOBILL RECURRING ORDERS!
        // NOTE: USE THE RECURRINGIMPORT.ASPX PAGE FOR THOSE!!
        
		protected override void OnInit(EventArgs e)
		{
			FilteredListing.SqlQuery = "select {0} ShoppingCart.OriginalRecurringOrderNumber, ShoppingCart.CustomerID, ShoppingCart.NextRecurringShipDate, Store.Name, Customer.Email from ShoppingCart with (NOLOCK) LEFT JOIN Store on ShoppingCart.StoreId = store.StoreId LEFT JOIN Customer Customer ON ShoppingCart.CustomerID = Customer.CustomerID where CartType=" + ((int)CartTypeEnum.RecurringCart).ToString() + " and {1}";
			base.OnInit(e);
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			if (OrdersArePendingToday())
			{
				btnProcessAll.Enabled = true;
			}
			else
			{
				AlertMessage.PushAlertMessage(AppLogic.GetString("admin.recurring.NoRecurringShipmentsDueToday", ThisCustomer.LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Warning);
			}
		}

		protected bool OrdersArePendingToday()
		{
			string countSql = "SELECT COUNT(*) AS N FROM ShoppingCart WITH (NOLOCK) WHERE CartType = @CartType AND NextRecurringShipDate < DATEADD(d,1,GETDATE())";
			List<SqlParameter> countParams = new List<SqlParameter> { (new SqlParameter("@CartType", (int)CartTypeEnum.RecurringCart))};

			int ordersPendingToday = DB.GetSqlN(countSql, countParams.ToArray());

			return ordersPendingToday > 0;
		}

		protected void btnProcessAll_Click(Object sender, EventArgs e)
		{
			StringBuilder output = new StringBuilder();

			using(SqlConnection conn = DB.dbConn())
			{
				conn.Open();
				using(IDataReader rsp = DB.GetRS("Select distinct(OriginalRecurringOrderNumber) from ShoppingCart where RecurringSubscriptionID='' and CartType=" + ((int)CartTypeEnum.RecurringCart).ToString() + " and NextRecurringShipDate < dateadd(d,1,getDate())", conn))
				{
					RecurringOrderMgr rmgr = new RecurringOrderMgr(EntityHelpers, GetParser);
					while(rsp.Read())
					{
						output.Append(String.Format(AppLogic.GetString("admin.recurring.ProcessingNextOccurrence", SkinID, LocaleSetting), DB.RSFieldInt(rsp, "OriginalRecurringOrderNumber").ToString()));
						output.Append(rmgr.ProcessRecurringOrder(DB.RSFieldInt(rsp, "OriginalRecurringOrderNumber")));
						output.Append("...<br/>");
					}
				}
			}

			AlertMessage.PushAlertMessage(output.ToString(), AspDotNetStorefrontControls.AlertMessage.AlertType.Info);
		}
    }
}
