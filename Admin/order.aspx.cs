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
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontGateways;
using AspDotNetStorefrontGateways.Processors;
using System.Linq;

namespace AspDotNetStorefrontAdmin
{
	public enum OrderCancelActions
	{
		None,
		Adhoc,
		Refund,
		Void,
		ForceRefund,
		ForceVoid,
		MarkAsFraud,
		ClearFraud,
		CancelRecurring,
		AdjustTotal
	}

	public partial class orderdetail : AdminPageBase
	{
		private int OrderNumber { get; set; }
		private int StoreId { get; set; }
		private Customer OrderCustomer { get; set; }
		private Order CurrentOrder { get; set; }
		private bool ShipRushEnabledAndConfigured { get; set; }
		private bool HasDownloadItemsDelayed { get; set; }

		protected void Page_Load(object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			OrderNumber = CommonLogic.QueryStringNativeInt("ordernumber");
			CurrentOrder = new Order(OrderNumber);
			OrderCustomer = new Customer(CurrentOrder.CustomerID);
			StoreId = Order.GetOrderStoreID(OrderNumber);

			if(!IsPostBack)
			{
				if(CurrentOrder.IsEmpty)
				{
					ShowMessage(AppLogic.GetString("admin.orderframe.OrderNotFoundOrOrderHasBeenDeleted", ThisCustomer.LocaleSetting), true);
					pnlOrderDetails.Visible = false;
					return;
				}

				ShipRushUpdate();
				ShippingManagerUpdate();
				SetupPromotionDisplay();
				SetupLineItemDisplay();
				BindDownloadsGrid();
				SetupOrderDisplay();

				dpShippedOn.Culture = Thread.CurrentThread.CurrentUICulture;
			}
		}

		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);

			btnClose.DataBind();
			btnCloseTop.DataBind();
		}

		#region Page Setup
		private void SetupOrderDisplay()
		{
			//Renew the order object here, as it may have changed after a postback and we need to update fields.
			CurrentOrder = new Order(OrderNumber);

			//Simple display stuff
			lblOrderNumber.Text = FormatStringForDisplay(OrderNumber.ToString());
			litOrderDate.Text = FormatStringForDisplay(FormatDateTime(CurrentOrder.OrderDate));
			litCustomerID.Text = FormatStringForDisplay(OrderCustomer.CustomerID.ToString());
			lnkOrderHistory.Text = FormatStringForDisplay(String.Format(AppLogic.GetString("admin.orderdetails.PreviousOrders", ThisCustomer.LocaleSetting), GetOrderCount(OrderCustomer.CustomerID).ToString()));
			lnkOrderHistory.NavigateUrl = "customer_history.aspx?customerid=" + OrderCustomer.CustomerID.ToString();
			litAffiliateID.Text = FormatStringForDisplay(CurrentOrder.AffiliateID.ToString());
			litReferrer.Text = FormatStringForDisplay(GetOrderStringField(OrderNumber, "Referrer"));
			litCustomerRegisterDate.Text = FormatDateTime(GetCustomerRegisterDate(OrderCustomer.CustomerID));
			lnkCustomerName.Text = FormatStringForDisplay(String.Format("{0} {1}", GetOrderStringField(OrderNumber, "FirstName"), GetOrderStringField(OrderNumber, "LastName")));
			lnkCustomerName.NavigateUrl = String.Format("customer.aspx?customerid={0}", OrderCustomer.CustomerID);
			litCustomerPhone.Text = FormatStringForDisplay(OrderCustomer.Phone);
			txtCustomerEmail.Text = FormatStringForDisplay(CurrentOrder.EMail);
			litBillingAddress.Text = FormatAddress(CurrentOrder.BillingAddress);
			litShippingAddress.Text = (AppLogic.AppConfigBool("AllowMultipleShippingAddressPerOrder") && CurrentOrder.HasMultipleShippingAddresses())
				? AppLogic.GetString("checkoutreview.aspx.25", ThisCustomer.LocaleSetting) : FormatAddress(CurrentOrder.ShippingAddress);
			litPaymentGateway.Text = FormatStringForDisplay(CurrentOrder.PaymentGateway);
			litPaymentMethod.Text = FormatStringForDisplay(CurrentOrder.PaymentMethod);
			litTransactionState.Text = FormatStringForDisplay(CurrentOrder.TransactionState);
			litAVSResult.Text = FormatStringForDisplay(GetOrderStringField(OrderNumber, "AVSResult"));
			litOrderTotal.Text = GetOrderBooleanField(OrderNumber, "QuoteCheckout") ? AppLogic.GetString("admin.orderframe.RequestForQuote", LocaleSetting) : ThisCustomer.CurrencyString(CurrentOrder.Total(true));
			txtOrderWeight.Text = Localization.CurrencyStringForGatewayWithoutExchangeRate(CurrentOrder.OrderWeight);
			litAuthorizedOn.Text = FormatDateTime(CurrentOrder.AuthorizedOn);
			litCapturedOn.Text = FormatDateTime(CurrentOrder.CapturedOn);
			litRefundedOn.Text = FormatDateTime(CurrentOrder.RefundedOn);
			litVoidedOn.Text = FormatDateTime(CurrentOrder.VoidedOn);
			litFraudedOn.Text = FormatDateTime(CurrentOrder.FraudedOn);
			litReceiptSentOn.Text = FormatDateTime(CurrentOrder.ReceiptEMailSentOn);

			//Localization
			if(AppLogic.NumLocaleSettingsInstalled() > 1)
			{
				litCustomerLocale.Text = FormatStringForDisplay(CurrentOrder.LocaleSetting);

				divLocale.Visible = true;
			}

			//MultiStore
			if(Store.StoreCount > 1)
			{
				litStoreId.Text = FormatStringForDisplay(StoreId.ToString());
				litStoreName.Text = FormatStringForDisplay(Store.GetStoreName(StoreId));

				divStore.Visible = true;
			}

			//Maxmind
			if(AppLogic.AppConfigBool("MaxMind.Enabled"))
			{
				litMaxMindScore.Text = FormatStringForDisplay(CurrentOrder.MaxMindFraudScore.ToString());
				lnkMaxMindDetails.NavigateUrl = AppLogic.AppConfig("MaxMind.ExplanationLink");

				divMaxMind.Visible = true;
			}
			else
			{
				lnkMaxMindDetails.Visible = false;
			}

			//Parent Order
			if(CurrentOrder.ParentOrderNumber > 0)
			{
				divParentOrder.Visible = true;
				lnkParentOrder.NavigateUrl = String.Format("order.aspx?ordernumber={0}", CurrentOrder.ParentOrderNumber);
				lnkParentOrder.Text = CurrentOrder.ParentOrderNumber.ToString();
			}

			//Related Order
			if(CurrentOrder.RelatedOrderNumber > 0)
			{
				divRelatedOrder.Visible = true;
				lnkRelatedOrder.NavigateUrl = String.Format("order.aspx?ordernumber={0}", CurrentOrder.RelatedOrderNumber);
				lnkRelatedOrder.Text = CurrentOrder.RelatedOrderNumber.ToString();
			}

			//Child Orders
			if(!String.IsNullOrEmpty(CurrentOrder.ChildOrderNumbers))
			{
				List<Order> childOrders = new List<Order>();
				foreach(string child in CurrentOrder.ChildOrderNumbers.Split(','))
				{
					Order childOrder = new Order(int.Parse(child));
					childOrders.Add(childOrder);
				}

				rptChildOrders.DataSource = childOrders;
				rptChildOrders.DataBind();

				divChildOrders.Visible = true;
			}

			//Payment Info
			string paymentMethod = CurrentOrder.PaymentMethod;
			string paymentGateway = CurrentOrder.PaymentGateway;
			bool isPayPal = (paymentMethod == AppLogic.ro_PMPayPal || paymentMethod == AppLogic.ro_PMPayPalExpress || paymentGateway == Gateway.ro_GWPAYPALPRO);

			if(paymentMethod == AppLogic.ro_PMCreditCard)
			{
				string ccType = GetOrderStringField(OrderNumber, "CardType");

				litCCType.Text = FormatStringForDisplay(ccType);
				litCCNumber.Text = FormatCardNumberForDisplay(ccType);
				litCCLastFour.Text = FormatStringForDisplay(CurrentOrder.Last4);
				litCCExpirationDate.Text = (litCCNumber.Text == AppLogic.ro_CCNotStoredString) ? 
					AppLogic.ro_CCNotStoredString : 
					CurrentOrder.CardExpirationMonth + "/" + CurrentOrder.CardExpirationYear;

				divCCInfo.Visible = true;

				if(AppLogic.AppConfigBool("ShowCardStartDateFields"))
				{
					litCCStartDate.Text = Localization.ParseLocaleDateTime(GetOrderStringField(OrderNumber, "CardStartDate"), ThisCustomer.LocaleSetting).ToString();
					litCCIssueNumber.Text = GetOrderMungedStringField(OrderNumber, "CardIssueNumber");

					divCCIssueInfo.Visible = true;
				}
			}
			else if(paymentMethod == AppLogic.ro_PMECheck)
			{
				SetupECheckDisplay();
			}
			else if(isPayPal)
			{
				divPayPalInfo.Visible = true;
			}
			else if(paymentMethod == AppLogic.ro_PMAmazonSimplePay ||
				paymentGateway == Gateway.ro_GWAMAZONSIMPLEPAY ||
				paymentMethod.ToLower() == GatewayCheckoutByAmazon.CheckoutByAmazon.CBA_Gateway_Identifier.ToLower())
			{
				divAmazonInfo.Visible = true;
				litAmazonManage.Visible = paymentMethod.EqualsIgnoreCase(GatewayCheckoutByAmazon.CheckoutByAmazon.CBA_Gateway_Identifier);

				litAmazonOrderIds.Text = FormatStringForDisplay(CurrentOrder.AuthorizationPNREF);
				litAmazonFeedIds.Text = FormatStringForDisplay(CurrentOrder.FinalizationData);
			}

			//Delivery
			bool hasShippableComponents = AppLogic.OrderHasShippableComponents(OrderNumber);
			bool hasDownloadComponents = CurrentOrder.HasDownloadComponents(false);

			if(hasShippableComponents)
			{
				dpShippedOn.SelectedDate = CurrentOrder.ShippedOn > System.DateTime.MinValue ? CurrentOrder.ShippedOn : System.DateTime.Now;
				dpShippedOn.Enabled = CurrentOrder.ShippedOn == System.DateTime.MinValue && hasShippableComponents;
				txtShippedVia.Text = GetOrderStringField(OrderNumber, "ShippedVIA");
				txtShippedVia.Enabled = txtShippedVia.Text.Length < 1 && hasShippableComponents;
				txtTrackingNumber.Text = GetOrderStringField(OrderNumber, "ShippingTrackingNumber");
				txtTrackingNumber.Enabled = txtTrackingNumber.Text.Length < 1 && hasShippableComponents;
				litShippingMethod.Text = CurrentOrder.ShippingMethod.Contains("|") ? CurrentOrder.ShippingMethod.Substring(0, CurrentOrder.ShippingMethod.IndexOf("|")) : CurrentOrder.ShippingMethod;
				litShippingPricePaid.Text = ThisCustomer.CurrencyString(CurrentOrder.ShippingTotal(true));

				//Multiship
				if(CurrentOrder.HasMultipleShippingAddresses())
				{
					divMultiShip.Visible = true;
				}
				litMultipleShippingAddresses.Text = AppLogic.GetString("admin.common.yes", ThisCustomer.LocaleSetting);

				divShippingDeliveryInfo.Visible = true;
			}

			if(hasDownloadComponents)
			{
				litHasDownloadItems.Text = CurrentOrder.HasDownloadComponents(false) ? AppLogic.GetString("admin.common.yes", ThisCustomer.LocaleSetting)
					: AppLogic.GetString("admin.common.no", ThisCustomer.LocaleSetting);
				litAllDownloaditems.Text = CurrentOrder.IsAllDownloadComponents() ? AppLogic.GetString("admin.common.yes", ThisCustomer.LocaleSetting)
					: AppLogic.GetString("admin.common.no", ThisCustomer.LocaleSetting);

				divDelayedDownloadWarning.Visible = litDelayedDownloadWarning.Visible = HasDownloadItemsDelayed;

				divDownloadDeliveryInfo.Visible = true;
			}

			if(hasShippableComponents && CurrentOrder.HasDistributorComponents())
			{
				litHasDistributorItems.Text = FormatStringForDisplay(AppLogic.GetString("admin.common.yes", ThisCustomer.LocaleSetting));
				litDistributorEmailSentOn.Text = FormatDateTime(CurrentOrder.DistributorEMailSentOn);
				litDistributorNotifications.Text = FormatStringForDisplay(AppLogic.GetAllDistributorNotifications(CurrentOrder));

				divDistributorDeliveryInfo.Visible = true;
			}

			//Notes
			txtFinalizationData.Text = CurrentOrder.FinalizationData;
			txtOrderNotes.Text = CurrentOrder.OrderNotes;
			txtAdminNotes.Text = GetOrderStringField(OrderNumber, "Notes");
			txtCustomerServiceNotes.Text = CurrentOrder.CustomerServiceNotes;
			litCustomerServiceVisible.Text = String.Format("{0} {1} {2})",
				AppLogic.AppConfigBool("ShowCustomerServiceNotesInReceipts") ? AppLogic.GetString("admin.common.yes", ThisCustomer.LocaleSetting) : AppLogic.GetString("admin.common.no", ThisCustomer.LocaleSetting),
				AppLogic.GetString("admin.orderframe.EditableHere", ThisCustomer.LocaleSetting),
				AppLogic.GetString("admin.common.yes", ThisCustomer.LocaleSetting)
					);

			//Debug info
			if(ThisCustomer.AdminCanViewCC)
			{
				divTransactionInfoWrap.Visible = true;
				txtTransactionCommand.Text = GetOrderStringField(OrderNumber, "TransactionCommand");
				divTransactionCommand.Visible = txtTransactionCommand.Text.Length > 0;
				txtAuthorizationResult.Text = GetOrderStringField(OrderNumber, "AuthorizationResult");
				divAuthorizationResult.Visible = txtAuthorizationResult.Text.Length > 0;
				txtAuthorizationCode.Text = CurrentOrder.AuthorizationCode;
				divAuthorizationCode.Visible = txtAuthorizationCode.Text.Length > 0;
				txtCaptureCommand.Text = CurrentOrder.CaptureTXCommand;
				divCaptureCommand.Visible = txtCaptureCommand.Text.Length > 0;
				txtCaptureResult.Text = CurrentOrder.CaptureTXResult;
				divCaptureResult.Visible = txtCaptureResult.Text.Length > 0;
				txtVoidCommand.Text = GetOrderStringField(OrderNumber, "VoidTXCommand");
				divVoidCommand.Visible = txtVoidCommand.Text.Length > 0;
				txtVoidResult.Text = GetOrderStringField(OrderNumber, "VoidTXResult");
				divVoidResult.Visible = txtVoidResult.Text.Length > 0;
				txtRefundCommand.Text = CurrentOrder.RefundTXCommand;
				divRefundCommand.Visible = txtRefundCommand.Text.Length > 0;
				txtRefundResult.Text = CurrentOrder.RefundTXResult;
				divRefundResult.Visible = txtRefundResult.Text.Length > 0;

				if(AppLogic.AppConfigBool("CardinalCommerce.Centinel.Enabled"))
				{
					txtCardinalLookup.Text = GetOrderStringField(OrderNumber, "CardinalLookupResult");
					divCardinalLookup.Visible = txtCardinalLookup.Text.Length > 0;
					txtCardinalAuthenticate.Text = GetOrderStringField(OrderNumber, "CardinalAuthenticateResult");
					divCardinalAuthenticate.Visible = txtCardinalAuthenticate.Text.Length > 0;
					txtCardinalParams.Text = GetOrderStringField(OrderNumber, "CardinalGatewayParms");
					divCardinalParams.Visible = txtCardinalParams.Text.Length > 0;
				}
				else if(GetOrderStringField(OrderNumber, "CardinalLookupResult").Length > 0)
				{
					txtThreedSecure.Text = GetOrderStringField(OrderNumber, "CardinalLookupResult");
					div3dSecure.Visible = true;
				}
			}

			if(ThisCustomer.IsAdminSuperUser)
			{
				divXmlInfoWrap.Visible = true;
				litOrderXml.Text = XmlCommon.PrettyPrintXml(AppLogic.RunXmlPackage("DumpOrder", null, ThisCustomer, SkinID, "", "OrderNumber=" + OrderNumber.ToString(), false, true));
			}

			if(ThisCustomer.AdminCanViewCC && (CurrentOrder.RecurringSubscriptionID.Length > 0 || CurrentOrder.TransactionType == AppLogic.TransactionTypeEnum.RECURRING_AUTO))
			{
				divRecurringInfoWrap.Visible = true;

				txtRecurringCommand.Text = FormatStringForDisplay(GetOrderStringField(OrderNumber, "RecurringSubscriptionCommand"));
				txtRecurringResult.Text = FormatStringForDisplay(GetOrderStringField(OrderNumber, "RecurringSubscriptionResult"));

				if(CurrentOrder.PaymentGateway == AspDotNetStorefrontGateways.Gateway.ro_GWPAYFLOWPRO)
				{
					lnkRecurringStatus.NavigateUrl = String.Format("recurringgatewaydetails.aspx?RecurringSubscriptionID={0}", CurrentOrder.RecurringSubscriptionID);
					lnkRecurringStatus.Text = FormatStringForDisplay(CurrentOrder.RecurringSubscriptionID);
					lnkRecurringStatus.Visible = true;
				}
				else
				{
					litRecurringSubscriptionId.Text = FormatStringForDisplay(CurrentOrder.RecurringSubscriptionID);
					litRecurringSubscriptionId.Visible = true;
				}

			}

			txtRTShippingRequest.Text = FormatStringForDisplay(GetOrderStringField(OrderNumber, "RTShipRequest"));
			txtRTShippingResponse.Text = FormatStringForDisplay(GetOrderStringField(OrderNumber, "RTShipResponse"));

			//More complicated features
			SetButtonState();
			SetupCancelActions();

			//ShipRush is on but not set up properly
			if(AppLogic.AppConfigBool("ShipRush.Enabled") && !ShipRushEnabledAndConfigured)
				ShowMessage(AppLogic.GetString("admin.ShipRushWarningMessage", ThisCustomer.LocaleSetting), true);
		}

		private void SetButtonState()
		{
			string transactionState = CurrentOrder.TransactionState;

			btnAdjustOrderWeight.Enabled = !CurrentOrder.HasMultipleShippingAddresses();

			btnCapture.Enabled = (transactionState == AppLogic.ro_TXStateAuthorized || transactionState == AppLogic.ro_TXStatePending)
				&& CurrentOrder.TransactionType != AppLogic.TransactionTypeEnum.RECURRING_AUTO;

			btnEdit.Enabled = btnEditBottom.Enabled = AppLogic.AppConfigBool("OrderEditingEnabled") && CurrentOrder.IsEditable() && !OrderCustomer.IsAdminSuperUser && !OrderCustomer.IsAdminUser;

			btnMarkAsShipped.Enabled = !CurrentOrder.HasBeenEdited && AppLogic.OrderHasShippableComponents(OrderNumber) && CurrentOrder.ShippedOn == System.DateTime.MinValue;

			btnSendToShipRush.Enabled = ShipRushEnabledAndConfigured &&
				(transactionState == AppLogic.ro_TXStateAuthorized || transactionState == AppLogic.ro_TXStateCaptured || transactionState == AppLogic.ro_TXStatePending) &&
				!CurrentOrder.HasBeenEdited &&
				CurrentOrder.TransactionType == AppLogic.TransactionTypeEnum.CHARGE;
			btnSendToShipRush.Text = CurrentOrder.ShippedOn == System.DateTime.MinValue ? AppLogic.GetString("admin.orderframe.SendToShipRush", ThisCustomer.LocaleSetting)
				: AppLogic.GetString("admin.orderframe.ReSendToShipRush", ThisCustomer.LocaleSetting);

			btnSendToShipManager.Enabled = AppLogic.AppConfigBool("FedExShipManager.Enabled") &&
				(transactionState == AppLogic.ro_TXStateAuthorized || transactionState == AppLogic.ro_TXStateCaptured || transactionState == AppLogic.ro_TXStatePending) &&
				!CurrentOrder.HasBeenEdited &&
				CurrentOrder.TransactionType == AppLogic.TransactionTypeEnum.CHARGE;
			btnSendToShipManager.Text = CurrentOrder.ShippedOn == System.DateTime.MinValue ? AppLogic.GetString("admin.orderframe.SendToFedExShipManager", ThisCustomer.LocaleSetting)
				: AppLogic.GetString("admin.orderframe.ReSendToFedExShipManager", ThisCustomer.LocaleSetting);

			btnGetMaxMind.Enabled = CurrentOrder.MaxMindFraudScore == -1 && AppLogic.AppConfigBool("MaxMind.Enabled");

			btnReceiptEmail.Enabled = !CurrentOrder.HasBeenEdited && (transactionState == AppLogic.ro_TXStateAuthorized || transactionState == AppLogic.ro_TXStateCaptured || transactionState == AppLogic.ro_TXStatePending);
			btnReceiptEmail.Text = CurrentOrder.ReceiptEMailSentOn == System.DateTime.MinValue ? AppLogic.GetString("admin.orderframe.SendReceiptEMail", ThisCustomer.LocaleSetting)
				: AppLogic.GetString("admin.orderframe.ReSendReceiptEmail", ThisCustomer.LocaleSetting);

			btnSendDistributorEmail.Enabled = !CurrentOrder.HasBeenEdited && (transactionState == AppLogic.ro_TXStateAuthorized || transactionState == AppLogic.ro_TXStateCaptured || transactionState == AppLogic.ro_TXStatePending);
			btnSendDistributorEmail.Text = CurrentOrder.DistributorEMailSentOn == System.DateTime.MinValue ? AppLogic.GetString("admin.orderframe.SendDistributorEmails", ThisCustomer.LocaleSetting)
				: AppLogic.GetString("admin.orderframe.ReSendDistributorEmails", ThisCustomer.LocaleSetting);

			btnPayPalReauth.Enabled = !CurrentOrder.HasBeenEdited &&
				(transactionState == AppLogic.ro_TXStateAuthorized || transactionState == AppLogic.ro_TXStatePending) &&
				CurrentOrder.TransactionType != AppLogic.TransactionTypeEnum.RECURRING_AUTO;

			btnUpdateAmazonTransaction.Enabled = (CurrentOrder.PaymentMethod == AppLogic.ro_PMAmazonSimplePay || CurrentOrder.PaymentGateway == Gateway.ro_GWAMAZONSIMPLEPAY) &&
				!CurrentOrder.HasBeenEdited &&
				(transactionState == AppLogic.ro_TXStateAuthorized || transactionState == AppLogic.ro_TXStatePending) &&
				CurrentOrder.TransactionType != AppLogic.TransactionTypeEnum.RECURRING_AUTO;

			//Add warnings to some of the button actions
			btnMarkAsShipped.OnClientClick = (transactionState == AppLogic.ro_TXStateCaptured) ?
				"return confirm('Are you sure you want to set the shipping info and email it to the customer?')"
				: "return confirm('Are you sure you want to proceed? The payment for this order has not yet cleared, and this will email the customer.')";

			btnSendDistributorEmail.OnClientClick = String.Format("return confirm('{0}');", AppLogic.GetString("admin.orderframe.QuerySendDistributorEmail", ThisCustomer.LocaleSetting));
			btnReceiptEmail.OnClientClick = String.Format("return confirm('{0}');", AppLogic.GetString("admin.orderframe.QuerySendReceiptEmail", ThisCustomer.LocaleSetting));
			btnChangeEmail.OnClientClick = String.Format("return confirm('{0}');", AppLogic.GetString("admin.orderframe.QueryChange", ThisCustomer.LocaleSetting));
			btnAdjustOrderWeight.OnClientClick = String.Format("return confirm('{0}');", AppLogic.GetString("admin.orderframe.QueryChange", ThisCustomer.LocaleSetting));
			btnCancel.OnClientClick = String.Format(@"
if (
	$('#ddlCancelActions').val() === 'MarkAsFraud'
	|| $('#ddlCancelActions').val() === 'ClearFraud'
) 
return confirm('{0}');", AppLogic.GetString("admin.orderframe.QueryMark", ThisCustomer.LocaleSetting));
			btnEdit.OnClientClick = String.Format("return confirm('{0}');", AppLogic.GetString("admin.orderframe.QueryEdit", ThisCustomer.LocaleSetting));
		}

		private void SetupCancelActions()
		{
			ddlCancelActions.Items.Clear();

			string paymentMethod = CurrentOrder.PaymentMethod;
			string paymentGateway = CurrentOrder.PaymentGateway;
			bool orderHasBeenEdited = CurrentOrder.HasBeenEdited;
			bool isCOD = (paymentMethod == AppLogic.ro_PMCOD || paymentMethod == AppLogic.ro_PMCODCompanyCheck || paymentMethod == AppLogic.ro_PMCODMoneyOrder || paymentMethod == AppLogic.ro_PMCODNet30);
			string transactionState = CurrentOrder.TransactionState;
			GatewayProcessor gateway = GatewayLoader.GetProcessor(paymentGateway);
			AppLogic.TransactionTypeEnum transactionType = CurrentOrder.TransactionType;

			bool adjustable = transactionState == AppLogic.ro_TXStateAuthorized &&
				(paymentMethod == AppLogic.ro_PMCreditCard
					|| paymentMethod == AppLogic.ro_PMMicropay
					|| paymentMethod == AppLogic.ro_PMPayPal
					|| isCOD) &&
				!CurrentOrder.HasBeenEdited &&
				gateway.SupportsAdHocOrders();

			bool adhocable = (CurrentOrder.ParentOrderNumber == 0 || transactionType == AppLogic.TransactionTypeEnum.RECURRING_AUTO) &&
				CurrentOrder.TransactionIsCaptured() &&
				(paymentMethod == AppLogic.ro_PMCreditCard || paymentMethod == AppLogic.ro_PMMicropay || paymentMethod == AppLogic.ro_PMPayPal) &&
				!CurrentOrder.HasBeenEdited &&
				(transactionType != AppLogic.TransactionTypeEnum.RECURRING_AUTO || CurrentOrder.AuthorizationPNREF.Length > 0) &&
				gateway.SupportsAdHocOrders();

			bool voidable = !CurrentOrder.HasBeenEdited &&
				(transactionState == AppLogic.ro_TXStateAuthorized || transactionState == AppLogic.ro_TXStateCaptured || transactionState == AppLogic.ro_TXStatePending) &&
				transactionType != AppLogic.TransactionTypeEnum.RECURRING_AUTO;

			bool forcevoidable = voidable;

			bool refundable = !orderHasBeenEdited &&
				transactionState == AppLogic.ro_TXStateCaptured &&
				(transactionType != AppLogic.TransactionTypeEnum.RECURRING_AUTO || CurrentOrder.AuthorizationPNREF.Length > 0);

			bool forcerefundable = refundable && (paymentMethod == AppLogic.ro_PMCreditCard || paymentMethod == AppLogic.ro_PMMicropay || paymentMethod == AppLogic.ro_PMAmazonSimplePay);

			bool fraudable = !orderHasBeenEdited &&
				(transactionState != AppLogic.ro_TXStateFraud && transactionType == AppLogic.TransactionTypeEnum.CHARGE) &&
				!Customer.StaticIsAdminSuperUser(CurrentOrder.CustomerID);

			bool clearfraudable = !orderHasBeenEdited && (transactionState == AppLogic.ro_TXStateFraud && transactionType == AppLogic.TransactionTypeEnum.CHARGE);

			bool cancellable = (CurrentOrder.ParentOrderNumber == 0 || transactionType == AppLogic.TransactionTypeEnum.RECURRING_AUTO) &&
				CurrentOrder.TransactionIsCaptured() &&
				(paymentMethod == AppLogic.ro_PMCreditCard || paymentMethod == AppLogic.ro_PMMicropay || paymentMethod == AppLogic.ro_PMPayPal) &&
				gateway.SupportsAdHocOrders() &&
				!CurrentOrder.HasBeenEdited &&
				(CurrentOrder.RecurringSubscriptionID.Length != 0 && CurrentOrder.AuthorizationPNREF.Length > 0 && CurrentOrder.RefundedOn == System.DateTime.MinValue);

			List<ListItem> cancelActions = new List<ListItem>();

			cancelActions.Add(new ListItem(AppLogic.GetString("admin.orderframe.AdjustOrderTotal", ThisCustomer.LocaleSetting), OrderCancelActions.AdjustTotal.ToString(), adjustable));
			cancelActions.Add(new ListItem(AppLogic.GetString("admin.orderframe.CreateAdhocChargeRefund", ThisCustomer.LocaleSetting), OrderCancelActions.Adhoc.ToString(), adhocable));
			cancelActions.Add(new ListItem(AppLogic.GetString("admin.orderframe.Void", ThisCustomer.LocaleSetting), OrderCancelActions.Void.ToString(), voidable));
			cancelActions.Add(new ListItem(AppLogic.GetString("admin.orderframe.ForceVoid", ThisCustomer.LocaleSetting), OrderCancelActions.ForceVoid.ToString(), forcevoidable));
			cancelActions.Add(new ListItem(AppLogic.GetString("admin.common.Refund", ThisCustomer.LocaleSetting), OrderCancelActions.Refund.ToString(), refundable));
			cancelActions.Add(new ListItem(AppLogic.GetString("admin.orderframe.ForceRefund", ThisCustomer.LocaleSetting), OrderCancelActions.ForceRefund.ToString(), forcerefundable));
			cancelActions.Add(new ListItem(AppLogic.GetString("admin.orderframe.MarkAsFraud", ThisCustomer.LocaleSetting), OrderCancelActions.MarkAsFraud.ToString(), (fraudable && ThisCustomer.IsAdminSuperUser)));
			cancelActions.Add(new ListItem(AppLogic.GetString("admin.orderframe.ClearFraudFlag", ThisCustomer.LocaleSetting), OrderCancelActions.ClearFraud.ToString(), (clearfraudable && ThisCustomer.IsAdminSuperUser)));
			cancelActions.Add(new ListItem(AppLogic.GetString("admin.orderframe.StopFutureBillingAndRefund", ThisCustomer.LocaleSetting), OrderCancelActions.CancelRecurring.ToString(), (cancellable)));

			if (cancelActions.Any(i => i.Enabled == true))
			{
				ddlCancelActions.Items.AddRange(cancelActions.Where(i => i.Enabled == true).ToArray());
				ddlCancelActions.Enabled = true;
				btnCancel.Enabled = true;
			}
		}

		private void SetupECheckDisplay()
		{
			string saltKey = Order.StaticGetSaltKey(OrderNumber);

			string realECheckABACode = string.Empty;
			string realCheckBankAccountNumber = string.Empty;

			string eCheckABACode = GetOrderStringField(OrderNumber, "ECheckBankABACode");
			string eCheckABACodeUnMunged = Security.UnmungeString(eCheckABACode, saltKey);

			if(eCheckABACodeUnMunged.StartsWith(Security.ro_DecryptFailedPrefix, StringComparison.InvariantCultureIgnoreCase))
			{
				// Failed decryption, must be clear text
				realECheckABACode = eCheckABACode;
			}
			else
			{
				// decryption successful, must be already encrypted
				realECheckABACode = eCheckABACodeUnMunged;
			}

			string eCheckBankAccountNumber = GetOrderStringField(OrderNumber, "ECheckBankAccountNumber");
			string eCheckBankAccountNumberUnMunged = Security.UnmungeString(eCheckBankAccountNumber, saltKey);

			if(eCheckBankAccountNumberUnMunged.StartsWith(Security.ro_DecryptFailedPrefix, StringComparison.InvariantCultureIgnoreCase))
			{
				// Failed decryption, must be clear text
				realCheckBankAccountNumber = eCheckBankAccountNumber;
			}
			else
			{
				// decryption successful, must be already encrypted
				realCheckBankAccountNumber = eCheckBankAccountNumberUnMunged;
			}

			// masked the account
			if(AppLogic.StoreCCInDB())
			{
				if(!CommonLogic.IsStringNullOrEmpty(realECheckABACode))
				{
					realECheckABACode = AppLogic.Mask(realECheckABACode);
				}

				if(!CommonLogic.IsStringNullOrEmpty(realCheckBankAccountNumber))
				{
					realCheckBankAccountNumber = AppLogic.Mask(realCheckBankAccountNumber);
				}
			}

			litECheckBankName.Text = GetOrderStringField(OrderNumber, "ECheckBankName");
			litEcheckABA.Text = realECheckABACode;
			litEcheckAccount.Text = realCheckBankAccountNumber;
			litECheckAccountName.Text = GetOrderStringField(OrderNumber, "ECheckBankAccountName");
			litEcheckAccountType.Text = GetOrderStringField(OrderNumber, "ECheckBankAccountType");

			divECheckinInfo.Visible = true;
		}

		private void SetupPromotionDisplay()
		{
			List<AdminPromoUsage> adminPromoUsages = new List<AdminPromoUsage>();

			using(SqlConnection promoConn = DB.dbConn())
			{
				SqlParameter[] promoSpa = { new SqlParameter("@OrderNumber", OrderNumber) };
				string promoSQL = @"SELECT pu.ShippingDiscountAmount, pu.LineItemDiscountAmount, pu.OrderDiscountAmount, pu.DiscountAmount, p.Code, 
												CASE  WHEN pu.ShippingDiscountAmount + pu.LineItemDiscountAmount + pu.OrderDiscountAmount != pu.DiscountAmount THEN 1
													  WHEN pu.ShippingDiscountAmount + pu.LineItemDiscountAmount + pu.OrderDiscountAmount = pu.DiscountAmount THEN 0
													END
												AS GiftWithPurchase
											FROM PromotionUsage pu
											INNER JOIN Promotions p ON pu.PromotionID = p.ID
											WHERE pu.OrderId = @OrderNumber";

				promoConn.Open();
				using(IDataReader promoRS = DB.GetRS(promoSQL, promoSpa, promoConn))
				{
					while(promoRS.Read())
					{
						AdminPromoUsage usage = new AdminPromoUsage()
						{
							Code = DB.RSField(promoRS, "Code"),
							LineItemDiscount = Localization.CurrencyStringForGatewayWithoutExchangeRate(DB.RSFieldDecimal(promoRS, "LineItemDiscountAmount")),
							ShippingDiscount = Localization.CurrencyStringForGatewayWithoutExchangeRate(DB.RSFieldDecimal(promoRS, "ShippingDiscountAmount")),
							OrderDiscount = Localization.CurrencyStringForGatewayWithoutExchangeRate(DB.RSFieldDecimal(promoRS, "OrderDiscountAmount")),
							TotalDiscount = Localization.CurrencyStringForGatewayWithoutExchangeRate(DB.RSFieldDecimal(promoRS, "DiscountAmount")),
							GiftWithPurchase = DB.RSFieldBool(promoRS, "GiftWithPurchase")
						};

						adminPromoUsages.Add(usage);
					}
				}
			}

			grdPromotions.DataSource = adminPromoUsages;
			grdPromotions.DataBind();
		}

		private void SetupLineItemDisplay()
		{
			grdProducts.DataSource = CurrentOrder.CartItems;
			grdProducts.DataBind();
		}

		private void BindDownloadsGrid()
		{
			List<DownloadItem> downloadItems = new List<DownloadItem>();

			foreach(CartItem c in CurrentOrder.CartItems)
			{
				if(c.IsDownload)
				{
					DownloadItem downloadItem = new DownloadItem();
					downloadItem.Load(c.ShoppingCartRecordID);

					if(downloadItem.Status == DownloadItem.DownloadItemStatus.Pending &&
						AppLogic.AppConfigBool("MaxMind.Enabled") &&
						CurrentOrder.MaxMindFraudScore >= AppLogic.AppConfigNativeDecimal("MaxMind.DelayDownloadThreshold"))
					{
						HasDownloadItemsDelayed = true;
					}

					downloadItems.Add(downloadItem);
				}
			}

			grdDownloadItems.DataSource = downloadItems;
			grdDownloadItems.DataBind();
		}
		#endregion

		#region Events
		public void btnChangeEmail_Click(object sender, EventArgs e)
		{
			string status = Gateway.OrderManagement_ChangeOrderEMail(CurrentOrder, ThisCustomer.LocaleSetting, txtCustomerEmail.Text.Trim());
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnCapture_Click(object sender, EventArgs e)
		{
			//Need to do a warning/prompt here first
			string status = Gateway.OrderManagement_DoCapture(CurrentOrder, ThisCustomer.LocaleSetting);
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnEdit_Click(object sender, EventArgs e)
		{
			Response.Redirect(String.Format("phoneorder.aspx?ordernumber={0}", OrderNumber));
		}

		public void btnMarkAsShipped_Click(object sender, EventArgs e)
		{
			AppLogic.eventHandler("OrderShipped").CallEvent("&OrderShipped=true&OrderNumber=" + OrderNumber.ToString());

			DateTime shippedOn = Localization.ParseNativeDateTime(dpShippedOn.SelectedDate.ToString());

			if(shippedOn == System.DateTime.MinValue)
				shippedOn = System.DateTime.Now;

			string shippedVia = txtShippedVia.Text.Trim();
			string trackingNumber = txtTrackingNumber.Text.Trim();

			string status = Gateway.OrderManagement_MarkAsShipped(CurrentOrder, ThisCustomer.LocaleSetting, shippedVia, trackingNumber, shippedOn);
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnAdjustOrderWeight_Click(object sender, EventArgs e)
		{
			string status = Gateway.OrderManagement_SetOrderWeight(CurrentOrder, ThisCustomer.LocaleSetting, decimal.Parse(txtOrderWeight.Text.Trim()));
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnSendToShipRush_Click(object sender, EventArgs e)
		{
			string status = Gateway.OrderManagement_SendToShipRush(CurrentOrder, ThisCustomer.LocaleSetting, ThisCustomer);
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnSendToShipManager_Click(object sender, EventArgs e)
		{
			string status = Gateway.OrderManagement_SendToFedexShippingMgr(CurrentOrder, ThisCustomer.LocaleSetting);
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnViewReceipt_Click(object sender, EventArgs e)
		{
			StringBuilder script = new StringBuilder();
			script.Append(String.Format("window.open('../receipt.aspx?ordernumber={0}&customerid={1}','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber, CurrentOrder.CustomerID));
			ClientScriptManager cs = Page.ClientScript;
			cs.RegisterClientScriptBlock(this.Page.GetType(), Guid.NewGuid().ToString(), script.ToString(), true);

			SetupOrderDisplay();
		}

		public void btnUpdateNotes_Click(object sender, EventArgs e)
		{
			string status = Gateway.OrderManagement_SetPrivateNotes(CurrentOrder, LocaleSetting, txtAdminNotes.Text.Trim());
			status = Gateway.OrderManagement_SetCustomerServiceNotes(CurrentOrder, LocaleSetting, txtCustomerServiceNotes.Text.Trim());
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnReceiptEmail_Click(object sender, EventArgs e)
		{
			string status = Gateway.OrderManagement_SendReceipt(CurrentOrder, LocaleSetting);
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnRegenerateReceipt_Click(object sender, EventArgs e)
		{
			string status = CurrentOrder.RegenerateReceipt(new Customer(CurrentOrder.CustomerID));
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnPayPalReauth_Click(object sender, EventArgs e)
		{
			StringBuilder script = new StringBuilder();
			script.Append(String.Format("window.open('paypalreauthorder.aspx?ordernumber={0}','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber));
			ClientScriptManager cs = Page.ClientScript;
			cs.RegisterClientScriptBlock(this.Page.GetType(), Guid.NewGuid().ToString(), script.ToString(), true);

			SetupOrderDisplay();
		}

		public void btnUpdateAmazonTransaction_Click(object sender, EventArgs e)
		{
			StringBuilder script = new StringBuilder();
			script.Append(String.Format("window.open('amazontransaction.aspx?ordernumber={0}','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber));
			ClientScriptManager cs = Page.ClientScript;
			cs.RegisterClientScriptBlock(this.Page.GetType(), Guid.NewGuid().ToString(), script.ToString(), true);

			SetupOrderDisplay();
		}

		public void btnSendDistributorEmail_Click(object sender, EventArgs e)
		{
			string status = Gateway.OrderManagement_SendDistributorNotification(CurrentOrder, true);
			ShowMessage(status, status != AppLogic.ro_OK);

			SetupOrderDisplay();
		}

		public void btnReleaseDownload_Click(object sender, EventArgs e)
		{
			Button btn = (Button)sender;
			int itemId;

			GridViewRow row = btn.NamingContainer as GridViewRow;

			TextBox locationBox = row.FindControl("txtDownloadLocation") as TextBox;

			if(int.TryParse(btn.CommandArgument, out itemId))
			{
				DownloadItem downloadItem = new DownloadItem();
				downloadItem.Load(itemId);

				if(locationBox != null)
				{
					string enteredLocation = locationBox.Text.Trim();
					if(enteredLocation != null && enteredLocation.Length > 0)
					{
						string updatedLocation = (enteredLocation.Contains("http:") || enteredLocation.Contains("https:")) ? enteredLocation : string.Format("../{0}", enteredLocation.ToString());
						downloadItem.UpdateDownloadLocation(updatedLocation);
					}
				}

				downloadItem.Release(true);
				downloadItem.SendDownloadEmailNotification(true);
			}

			BindDownloadsGrid();
			SetupOrderDisplay();
		}

		public void btnGetMaxMind_Click(object sender, EventArgs e)
		{
			try
			{
				String fraudDetails = String.Empty;
				Address billingAddress = new Address();
				billingAddress.LoadByCustomer(CurrentOrder.CustomerID, AddressTypes.Billing);
				Address shippingAddress = new Address();
				shippingAddress.LoadByCustomer(CurrentOrder.CustomerID, AddressTypes.Shipping);
				Customer customer = new Customer(CurrentOrder.CustomerID, true);
				Decimal fraudScore = Gateway.MaxMindFraudCheck(OrderNumber
				, customer
				, billingAddress
				, shippingAddress
				, CurrentOrder.Total(true)
				, customer.CurrencySetting
				, CurrentOrder.PaymentMethod
				, out fraudDetails);

				DB.ExecuteSQL(String.Format("update orders set MaxMindFraudScore={0}, MaxMindDetails={1} where OrderNumber={2}", Localization.DecimalStringForDB(fraudScore), DB.SQuote(fraudDetails), OrderNumber.ToString()));
			}
			catch(Exception ex)
			{
				DB.ExecuteSQL(String.Format("update orders set MaxMindFraudScore={0}, MaxMindDetails={1} where OrderNumber={2}", -1.0M, DB.SQuote(ex.Message), CurrentOrder.OrderNumber.ToString()));
			}

			SetupOrderDisplay();
		}

		public void btnCancel_Click(object sender, EventArgs e)
		{
			string action = ddlCancelActions.SelectedValue;
			StringBuilder script = new StringBuilder();

			switch(action)
			{
				case "None":
					{
						return;
					}
				case "Adhoc":
					{
						script.Append(String.Format("window.open('adhoccharge.aspx?ordernumber={0}','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber));
						break;
					}
				case "Void":
					{
						script.Append(String.Format("window.open('voidorder.aspx?ordernumber={0}','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber));
						break;
					}
				case "ForceVoid":
					{
						script.Append(String.Format("window.open('voidorder.aspx?ordernumber={0}&ForceVoid=1','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber));
						break;
					}
				case "Refund":
					{
						script.Append(String.Format("window.open('refundorder.aspx?ordernumber={0}','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber));
						break;
					}
				case "ForceRefund":
					{
						script.Append(String.Format("window.open('refundorder.aspx?ordernumber={0}&force=true','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber));
						break;
					}
				case "MarkAsFraud":
					{
						Gateway.OrderManagement_MarkAsFraud(CurrentOrder, ThisCustomer.LocaleSetting);
						return;
					}
				case "ClearFraud":
					{
						Gateway.OrderManagement_ClearFraud(CurrentOrder, LocaleSetting);
						return;
					}
				case "CancelRecurring":
					{
						script.Append(String.Format("window.open('recurringrefundcancel.aspx?ordernumber={0}','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber));
						break;
					}
				case "AdjustTotal":
					{
						script.Append(String.Format("window.open('adjustcharge.aspx?ordernumber={0}','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=600,height=500,left=0,top=0');\n", OrderNumber));
						break;
					}
			}

			ClientScriptManager cs = Page.ClientScript;
			cs.RegisterClientScriptBlock(this.Page.GetType(), Guid.NewGuid().ToString(), script.ToString(), true);

			SetupOrderDisplay();
		}

		protected void grdDownloadItems_OnRowDataBound(object sender, GridViewRowEventArgs e)
		{
			if(e.Row.RowType != DataControlRowType.DataRow)
				return;

			DownloadItem downloadItem = e.Row.DataItem as DownloadItem;

			Literal litDownloadItemName = e.Row.FindControl("litDownloadItemName") as Literal;
			Literal litDownloadReleasedOn = e.Row.FindControl("litDownloadReleasedOn") as Literal;
			Literal litDownloadExpiresOn = e.Row.FindControl("litDownloadExpiresOn") as Literal;
			TextBox txtDownloadLocation = e.Row.FindControl("txtDownloadLocation") as TextBox;
			Button btnReleaseDownload = e.Row.FindControl("btnReleaseDownload") as Button;

			if(litDownloadItemName != null)
				litDownloadItemName.Text = downloadItem.DownloadName;

			if(litDownloadReleasedOn != null)
				litDownloadReleasedOn.Text = FormatDateTime(downloadItem.ReleasedOn);

			if(litDownloadExpiresOn != null)
				litDownloadExpiresOn.Text = FormatDateTime(downloadItem.ExpiresOn);

			if(txtDownloadLocation != null)
				txtDownloadLocation.Text = downloadItem.DownloadLocation;

			if(btnReleaseDownload != null)
				btnReleaseDownload.Enabled = AppLogic.AppConfig("Download.ReleaseOnAction").EqualsIgnoreCase("manual") && downloadItem.DownloadLocation.Length != 0;

			if(btnReleaseDownload != null && downloadItem.ReleasedOn != null && downloadItem.ReleasedOn < System.DateTime.Now)
			{
				btnReleaseDownload.Text = "Re-Release Download";
			}
		}

		protected void grdDownloadItems_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			grdDownloadItems.PageIndex = e.NewPageIndex;
			BindDownloadsGrid();
		}

		protected void grdProducts_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			grdProducts.PageIndex = e.NewPageIndex;
			SetupLineItemDisplay();
		}

		protected void grdPromotions_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			grdPromotions.PageIndex = e.NewPageIndex;
			SetupPromotionDisplay();
		}

		protected void rptChildOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			var childOrder = e.Item.DataItem as Order;
			if(childOrder == null)
				return;

			HyperLink childLink = e.Item.FindControl("childLink") as HyperLink;

			if(childLink == null)
				return;

			childLink.NavigateUrl = String.Format("order.aspx?ordernumber={0}", childOrder.OrderNumber);
		}

		#endregion

		#region Lookup methods
		private int GetOrderCount(int CustomerId)
		{
			string lookupSQL = String.Format("select count(ordernumber) as N from orders   with (NOLOCK)  where TransactionState in ({0},{1}) AND CustomerID = @CustomerID",
				DB.SQuote(AppLogic.ro_TXStateCaptured),
				DB.SQuote(AppLogic.ro_TXStateAuthorized));

			List<SqlParameter> lookupParams = new List<SqlParameter>() { new SqlParameter("@CustomerID", CustomerId) };

			return DB.GetSqlN(lookupSQL, lookupParams.ToArray());
		}

		private string GetOrderMungedStringField(int OrderNum, string FieldName)
		{
			string fieldValue = String.Empty;
			string lookupSQL = String.Format("SELECT {0} FROM Orders WHERE OrderNumber = @OrderNumber", FieldName);
			List<SqlParameter> lookupParams = new List<SqlParameter>() { new SqlParameter("@OrderNumber", OrderNum) };

			using(SqlConnection lookupConn = new SqlConnection(DB.GetDBConn()))
			{
				lookupConn.Open();
				using(IDataReader reader = DB.GetRS(lookupSQL, lookupParams.ToArray(), lookupConn))
				{
					while(reader.Read())
					{
						fieldValue = Security.UnmungeString(DB.RSField(reader, FieldName));
					}
				}
			}

			return fieldValue;
		}

		private string GetOrderStringField(int OrderNum, string FieldName)
		{
			string fieldValue = String.Empty;
			string lookupSQL = String.Format("SELECT {0} FROM Orders WHERE OrderNumber = @OrderNumber", FieldName);
			List<SqlParameter> lookupParams = new List<SqlParameter>() { new SqlParameter("@OrderNumber", OrderNum) };

			using(SqlConnection lookupConn = new SqlConnection(DB.GetDBConn()))
			{
				lookupConn.Open();
				using(IDataReader reader = DB.GetRS(lookupSQL, lookupParams.ToArray(), lookupConn))
				{
					while(reader.Read())
					{
						fieldValue = DB.RSField(reader, FieldName);
					}
				}
			}

			return fieldValue;
		}

		private bool GetOrderBooleanField(int OrderNum, string FieldName)
		{
			bool fieldValue = false;
			string lookupSQL = String.Format("SELECT {0} FROM Orders WHERE OrderNumber = @OrderNumber", FieldName);
			List<SqlParameter> lookupParams = new List<SqlParameter>() { new SqlParameter("@OrderNumber", OrderNum) };

			using(SqlConnection lookupConn = new SqlConnection(DB.GetDBConn()))
			{
				lookupConn.Open();
				using(IDataReader reader = DB.GetRS(lookupSQL, lookupParams.ToArray(), lookupConn))
				{
					while(reader.Read())
					{
						fieldValue = DB.RSFieldBool(reader, FieldName);
					}
				}
			}

			return fieldValue;
		}

		private DateTime GetCustomerRegisterDate(int CustomerId)
		{
			DateTime registerDate = System.DateTime.MinValue;
			string lookupSQL = "SELECT RegisterDate FROM Customer WHERE CustomerID = @CustomerID";
			List<SqlParameter> lookupParams = new List<SqlParameter>() { new SqlParameter("@CustomerID", CustomerId) };

			using(SqlConnection lookupConn = new SqlConnection(DB.GetDBConn()))
			{
				lookupConn.Open();
				using(IDataReader reader = DB.GetRS(lookupSQL, lookupParams.ToArray(), lookupConn))
				{
					while(reader.Read())
					{
						registerDate = DB.RSFieldDateTime(reader, "RegisterDate");
					}
				}
			}

			return registerDate;
		}

		#endregion

		#region Display Formatting Methods
		private void ShowMessage(string Message, bool IsError)
		{
			if(Message == AppLogic.ro_OK)
				Message = AppLogic.GetString("admin.orderdetails.UpdateSuccessful", ThisCustomer.LocaleSetting);

			lblMessage.Text = Message;

			if(IsError)
				divMessage.Attributes.Add("class", "alert alert-danger");
			else
				divMessage.Attributes.Add("class", "alert alert-success");

			divMessage.Visible = true;
		}

		private string FormatAddress(AddressInfo Address)
		{
			string formattedAddress = string.Empty;

			formattedAddress += Address.m_FirstName + " " + Address.m_LastName;
			formattedAddress += Address.m_Company.Length > 0 ? "<div>" + Address.m_Company + "</div>" : string.Empty;
			formattedAddress += Address.m_Address1.Length > 0 ? "<div>" + Address.m_Address1 + "</div>" : string.Empty;
			formattedAddress += Address.m_Address2.Length > 0 ? "<div>" + Address.m_Address2 + "</div>" : string.Empty;
			formattedAddress += Address.m_Suite.Length > 0 ? "<div>" + Address.m_Suite + "</div>" : string.Empty;
			formattedAddress += Address.m_City.Length > 0 ? "<div>" + Address.m_City + ", " : "<div>";
			formattedAddress += Address.m_State.Length > 0 ? Address.m_State + " " : string.Empty;
			formattedAddress += Address.m_Zip.Length > 0 ? Address.m_Zip + "</div>" : "</div>";
			formattedAddress += Address.m_Country.Length > 0 ? "<div>" + Address.m_Country + "</div>" : string.Empty;

			return formattedAddress;
		}

		private string FormatDateTime(DateTime OriginalTime)
		{
			string displayDate = "N/A";

			if(OriginalTime != null && OriginalTime != System.DateTime.MinValue)
				displayDate = Localization.ToNativeDateTimeString(OriginalTime);

			return displayDate;
		}

		private string FormatStringForDisplay(string OriginalString)
		{
			string displayString = "N/A";

			if(!String.IsNullOrEmpty(OriginalString) && OriginalString != "0")
				displayString = OriginalString;

			return displayString;
		}

		private string FormatCardNumberForDisplay(string CardType)  //Weird thing to pass in, but it saves a DB lookup
		{
			string cardNumber = String.Empty;

			//Might be PayPal info
			if(CardType.StartsWith(AppLogic.ro_PMPayPal, StringComparison.InvariantCultureIgnoreCase))
			{
				cardNumber = AppLogic.GetString("admin.orders.PaymentMethod.PayPal", ThisCustomer.LocaleSetting);
				return cardNumber;
			}

			//Maybe we didn't store anything at all?
			if((!AppLogic.AppConfigBool("StoreCCInDB") || CurrentOrder.CardNumber.Length == 0 || CurrentOrder.CardNumber == AppLogic.ro_CCNotStoredString))
			{
				cardNumber = AppLogic.GetString("admin.orderframe.NotStored", ThisCustomer.LocaleSetting);

				return cardNumber;
			}

			//Finally, try for the real thing
			if(AppLogic.AppConfigBool("StoreCCInDB") && ThisCustomer.AdminCanViewCC)
			{
				cardNumber = AppLogic.AdminViewCardNumber(CurrentOrder.CardNumber, "Orders", OrderNumber);
				if(cardNumber.Length > 0 && cardNumber != AppLogic.ro_CCNotStoredString) //log admin viewing card number
				{
					Security.LogEvent("Viewed Credit Card", AppLogic.GetString("admin.orderframe.ViewedCardNumber", SkinID, LocaleSetting) + cardNumber.Substring(cardNumber.Length - 4).PadLeft(cardNumber.Length, '*') + " " + AppLogic.GetString("admin.orderframe.ViewedCardNumberOnOrderNumber", SkinID, LocaleSetting) + OrderNumber.ToString(), OrderCustomer.CustomerID, ThisCustomer.CustomerID, Convert.ToInt32(ThisCustomer.CurrentSessionID));
				}
			}

			return cardNumber;
		}
		#endregion

		#region Maintenance Methods
		private void ShipRushUpdate()
		{
			if(AppLogic.AppConfigBool("ShipRush.Enabled"))
			{
				// look for status back from shiprush
				try
				{
					using(SqlConnection shipRushconn = DB.dbConn())
					{
						shipRushconn.Open();
						using(IDataReader rsJobHistory = DB.GetRS("select * from OR_JOBHISTORY where (TrackingNumber IS NOT NULL and TrackingNumber<>'') and JobID in (select 'OrderNumber_' + convert(varchar(10),OrderNumber) as JobID from orders  with (NOLOCK)  where ShippingTrackingNumber='Pending From ShipRush')", shipRushconn))
						{
							//this is just a flag if shiprush table is already configure
							ShipRushEnabledAndConfigured = true;
							while(rsJobHistory.Read())
							{
								String TN = DB.RSField(rsJobHistory, "TrackingNumber").Trim();
								String TNotes = DB.RSField(rsJobHistory, "Notes").Trim();
								String JobID = DB.RSField(rsJobHistory, "JobID").Trim();
								String orderNumber = String.Empty;
								try
								{
									orderNumber = JobID.Split('_')[1].Trim();
									if(orderNumber.Length != 0)
									{
										DB.ExecuteSQL(String.Format("update orders set CarrierReportedRate = {0}, ShippingTrackingNumber= {1} where ShippingTrackingNumber = {2} and OrderNumber = {3}",
											DB.SQuote(TNotes),
											DB.SQuote(TN),
											DB.SQuote("Pending From ShipRush"),
											orderNumber));
									}
								}
								catch(Exception ex)
								{
									SysLog.LogException(ex, MessageTypeEnum.GeneralException, MessageSeverityEnum.Error);
								}
							}
						}
					}
				}
				catch
				{
					ShipRushEnabledAndConfigured = false;
				}
			}
		}

		private void ShippingManagerUpdate()
		{
			if(AppLogic.AppConfigBool("FedExShipManager.Enabled"))
			{
				// look for status back from shipmanager
				using(SqlConnection shippingManagerConn = DB.dbConn())
				{
					shippingManagerConn.Open();
					using(IDataReader rsfedex = DB.GetRS("SELECT * FROM ShippingImportExport WHERE (TrackingNumber IS NOT NULL and TrackingNumber <> '') ", shippingManagerConn))
					{
						while(rsfedex.Read())
						{
							string tracking = DB.RSField(rsfedex, "TrackingNumber").Trim();
							string shippedVia = CommonLogic.IIF(DB.RSField(rsfedex, "ServiceCarrierCode").Length != 0, DB.RSField(rsfedex, "ServiceCarrierCode"), AppLogic.GetString("order.cs.1", SkinID, LocaleSetting));
							decimal cost = DB.RSFieldDecimal(rsfedex, "Cost");
							decimal weight = DB.RSFieldDecimal(rsfedex, "Weight");
							int ordno = DB.RSFieldInt(rsfedex, "OrderNumber");

							try
							{
								//send confirmation before we put the price in shippedVia
								Order.MarkOrderAsShipped(ordno, shippedVia, tracking, System.DateTime.Now, false, null, new Parser(null, 1, ThisCustomer), !AppLogic.AppConfigBool("BulkImportSendsShipmentNotifications"));
								//Update Orders
								DB.ExecuteSQL(String.Format("UPDATE Orders SET ShippedVia = {0}, CarrierReportedWeight = {1}, CarrierReportedRate = {2}, ShippingTrackingNumber = {3} WHERE OrderNumber = {4}",
									DB.SQuote(shippedVia + "|" + cost),
									DB.SQuote(weight.ToString()),
									DB.SQuote(cost.ToString()),
									DB.SQuote(tracking),
									ordno));

								//Delete from FedEx synch table
								DB.ExecuteSQL(String.Format("DELETE FROM ShippingImportExport WHERE OrderNumber = {0}", ordno));
							}
							catch(Exception ex)
							{
								SysLog.LogException(ex, MessageTypeEnum.GeneralException, MessageSeverityEnum.Error);
							}
						}
					}
				}
			}
		}

		#endregion
	}
}
