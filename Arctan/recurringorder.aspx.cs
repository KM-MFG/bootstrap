// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web.UI.WebControls;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontGateways.Processors;

namespace AspDotNetStorefrontAdmin
{
    /// <summary>
    /// Summary description for recurringorder.
    /// </summary>
    public partial class recurringorder : AdminPageBase
    {
		int OriginalRecurringOrderNumber = 0;
		Customer OrderCustomer;

		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);

			btnCloseTop.DataBind();
		}

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Response.CacheControl = "private";
            Response.Expires = 0;
            Response.AddHeader("pragma", "no-cache");

			OriginalRecurringOrderNumber = CommonLogic.QueryStringUSInt("originalorderid");

			if(OriginalRecurringOrderNumber == 0)
				Response.Redirect("recurringorders.aspx");

			OrderCustomer = new Customer(GetRecurringCartCustomerId());

			if (OrderCustomer.IsAdminUser && !ThisCustomer.IsAdminSuperUser)
			{
				divContent.Visible = false;
				AlertMessage.PushAlertMessage(AppLogic.GetString("admin.common.SecurityException", ThisCustomer.LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}

			if (!Page.IsPostBack)
			{
				dpNextShipDate.Culture = Thread.CurrentThread.CurrentUICulture;

				Order recurringOrder = new Order(OriginalRecurringOrderNumber);
				ShoppingCart recurringCart = new ShoppingCart(SkinID, OrderCustomer, CartTypeEnum.RecurringCart, OriginalRecurringOrderNumber, false);
				CartItem recurringItem = recurringCart.CartItems.FirstOrDefault(ci => ci.OriginalRecurringOrderNumber == OriginalRecurringOrderNumber);	//Need a recurring item from this order for some info later

				PopulateIntervalDropdown();
				grdProducts.DataSource = recurringCart.CartItems;
				grdProducts.DataBind();

				litOrderNumber.Text = OriginalRecurringOrderNumber.ToString();
				litRecurringIndex.Text = recurringItem.RecurringIndex.ToString();
				litOriginalDate.Text = Localization.ToThreadCultureShortDateString(recurringOrder.OrderDate);
				dpNextShipDate.SelectedDate = recurringItem.NextRecurringShipDate;
				txtInterval.Text = recurringItem.RecurringInterval.ToString();
				ddIntervalType.SelectedValue = ((int)recurringItem.RecurringIntervalType).ToString();
				ddIntervalType.Enabled = AppLogic.AppConfigBool("AllowRecurringIntervalEditing");
				addressFrame.Src = String.Format("editaddressrecurring.aspx?addressid={0}&originalrecurringordernumber={1}", OrderCustomer.PrimaryBillingAddressID, OriginalRecurringOrderNumber);

				//Some stuff can't be edited/processed here for gateway recurring billing or PayPal orders
				bool isPPECorder = (recurringOrder.PaymentMethod == AppLogic.ro_PMPayPalExpress);
				bool isPayPalPaymentsStandardOrder = (recurringOrder.PaymentMethod == AppLogic.ro_PMPayPal && recurringOrder.PaymentGateway != "PAYPAL" && recurringOrder.PaymentGateway != "PAYFLOWPRO");
				bool isGatewayAutoBillOrder = recurringItem.RecurringSubscriptionID != String.Empty;	//If there's a subscription, it's gateway recurring

				btnProcess.Visible = !isPPECorder;
				btnStopBilling.Visible = !isPayPalPaymentsStandardOrder;
				divAddressInfo.Visible = !isPPECorder;

				if (isGatewayAutoBillOrder)
				{
					txtInterval.Enabled = false;
					ddIntervalType.Enabled = false;

					lnkRetry.Visible = true;
					lnkRetry.PostBackUrl = String.Format("customer_history.aspx?customerid={0}&retrypaymentid={1}", OrderCustomer.CustomerID, OriginalRecurringOrderNumber);
					lnkRestart.Visible = true;
					lnkRestart.PostBackUrl = String.Format("customer_history.aspx?customerid={0}&restartid={1}", OrderCustomer.CustomerID, OriginalRecurringOrderNumber);
				}
			}
        }

		private int GetRecurringCartCustomerId()
		{
			string custSql = "SELECT CustomerID AS N FROM ShoppingCart WITH (NOLOCK) WHERE CartType = @CartType AND OriginalRecurringOrderNumber = @OriginalRecurringOrderNumber";
			List<SqlParameter> custParams = new List<SqlParameter> { (new SqlParameter("@CartType", (int)CartTypeEnum.RecurringCart)),
																		(new SqlParameter("@OriginalRecurringOrderNumber", OriginalRecurringOrderNumber)) };

			int customerId = DB.GetSqlN(custSql, custParams.ToArray());

			return customerId;
		}

		private void PopulateIntervalDropdown()
		{
			if (!AppLogic.UseSpecialRecurringIntervals())
			{
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.Day.ToString(), ((int)DateIntervalTypeEnum.Day).ToString()));
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.Week.ToString(), ((int)DateIntervalTypeEnum.Week).ToString()));
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.Month.ToString(), ((int)DateIntervalTypeEnum.Month).ToString()));
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.Year.ToString(), ((int)DateIntervalTypeEnum.Year).ToString()));
			}
			else
			{
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.Weekly.ToString(), DateIntervalTypeEnum.Weekly.ToString()));
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.BiWeekly.ToString(), DateIntervalTypeEnum.BiWeekly.ToString()));
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.Monthly.ToString(), DateIntervalTypeEnum.Monthly.ToString()));
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.Quarterly.ToString(), DateIntervalTypeEnum.Quarterly.ToString()));
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.SemiYearly.ToString(), DateIntervalTypeEnum.SemiYearly.ToString()));
				ddIntervalType.Items.Add(new ListItem(DateIntervalTypeEnum.Yearly.ToString(), DateIntervalTypeEnum.Yearly.ToString()));
			}
		}

		protected void btnStopBilling_Click(Object sender, EventArgs e)
		{
			try
			{
				DB.ExecuteSQL(String.Format("DELETE FROM ShoppingCart WHERE CustomerID = {0} AND OriginalRecurringOrderNumber = {1}", OrderCustomer.CustomerID, OriginalRecurringOrderNumber));
				DB.ExecuteSQL(String.Format("DELETE FROM KitCart WHERE CustomerID = {0} AND OriginalRecurringOrderNumber = {1}", OrderCustomer.CustomerID, OriginalRecurringOrderNumber));

				Response.Redirect("recurringorders.aspx");
			}
			catch (Exception ex)
			{
				AlertMessage.PushAlertMessage(ex.Message, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}
		}

		protected void btnProcess_Click(Object sender, EventArgs e)
		{
			if(OriginalRecurringOrderNumber != 0)
			{
				RecurringOrderMgr orderMgr = new RecurringOrderMgr(EntityHelpers, GetParser);
				string message = orderMgr.ProcessRecurringOrder(OriginalRecurringOrderNumber);

				AlertMessage.PushAlertMessage(message, (message == AppLogic.ro_OK) 
					? AspDotNetStorefrontControls.AlertMessage.AlertType.Success 
					: AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}
		}

		protected void btnUpdate_Click(Object sender, EventArgs e)
		{
			DateTime newShipDate = (DateTime)dpNextShipDate.SelectedDate;
			int newInterval = int.Parse(txtInterval.Text.Trim());
			int newIntervalType = int.Parse(ddIntervalType.SelectedValue);

			try 
			{ 
				if (newShipDate != null && newShipDate != System.DateTime.MinValue)
				{
					DB.ExecuteSQL(String.Format("update shoppingcart set NextRecurringShipDate={0} where originalrecurringordernumber={1}",
						DB.DateQuote(Localization.ToDBShortDateString(newShipDate)), OriginalRecurringOrderNumber));
				}

				if (newInterval != 0)
				{
					DB.ExecuteSQL(String.Format("update shoppingcart set RecurringInterval={0} where originalrecurringordernumber={1}",
						newInterval, OriginalRecurringOrderNumber));
				}

				if(newIntervalType != 0)
				{
					DB.ExecuteSQL(String.Format("update shoppingcart set RecurringIntervalType={0} where originalrecurringordernumber={1}",
						newIntervalType, OriginalRecurringOrderNumber));
				}

				AlertMessage.PushAlertMessage(AppLogic.GetString("admin.common.ItemUpdated", ThisCustomer.LocaleSetting), AspDotNetStorefrontControls.AlertMessage.AlertType.Success);
			}
			catch (Exception ex)
			{
				AlertMessage.PushAlertMessage(ex.Message, AspDotNetStorefrontControls.AlertMessage.AlertType.Error);
			}
		}		
    }
}
