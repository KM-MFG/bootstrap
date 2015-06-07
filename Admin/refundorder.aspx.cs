// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontGateways;

namespace AspDotNetStorefrontAdmin
{
	public partial class refundorder : AdminPageBase
	{

		#region PROPERTIES

		public int OrderNumber { get; set; }

		#endregion

		#region PAGE EVENTS

		/// <summary>
		/// Page Load
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			btnCancel.Text = AppLogic.GetString("admin.common.cancel", ThisCustomer.LocaleSetting);
			if(ThisCustomer.IsAdminUser)
			{
				divAllowed.Visible = true;
				OrderNumber = CommonLogic.QueryStringUSInt("OrderNumber");
				Order order = new Order(OrderNumber, ThisCustomer.LocaleSetting);
				if(order.OrderNumber > 0)
				{
					divHasOrderNumber.Visible = true;
					divIncorrectOrderNumber.Visible = false;
					lblOrderNumber.Text = order.OrderNumber.ToString();

					if(CommonLogic.FormCanBeDangerousContent("IsSubmit") == "true")
					{
						ProcessRefund(order);
					}
					else
					{
						refundForm.Visible = true;
						btnSubmit.Visible = true;
					}
				}
				else
				{
					divHasOrderNumber.Visible = false;
					divIncorrectOrderNumber.Visible = true;
					ctrlAlertMessageIncorrectOrderNumber.PushAlertMessage(AppLogic.GetString("admin.refund.InvalidOrderNumber", SkinID, LocaleSetting), AlertMessage.AlertType.Error);
				}
			}
			else
			{
				divAllowed.Visible = false;
				ctrlAlertMessageNoPermissions.PushAlertMessage(AppLogic.GetString("admin.refund.PermissionDenied", SkinID, LocaleSetting), AlertMessage.AlertType.Warning);
			}
		}

		#endregion

		#region PROCESS REFUNDS

		/// <summary>
		/// If the form is submitted, the refund will process, otherwise show message
		/// </summary>
		/// <param name="currentOrder"></param>
		private void ProcessRefund(Order currentOrder)
		{
			btnSubmit.Visible = false;
			refundForm.Visible = false;
			string RefundReason = CommonLogic.FormCanBeDangerousContent("RefundReason");
			string Status = Gateway.OrderManagement_DoFullRefund(currentOrder, ThisCustomer.LocaleSetting, RefundReason);

			if(Status == AppLogic.ro_OK)
			{
				ctrlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.refund.OrderWasRefunded", SkinID, LocaleSetting), AlertMessage.AlertType.Success);
				btnCancel.Text = AppLogic.GetString("admin.common.close", ThisCustomer.LocaleSetting);
			}
			else
			{
				ctrlAlertMessage.PushAlertMessage(AppLogic.GetString(Status, SkinID, LocaleSetting), AlertMessage.AlertType.Info);
			}
		}

		#endregion
	}
}
