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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontGateways;
using AspDotNetStorefrontGateways.Processors;

namespace AspDotNetStorefront
{
	public partial class checkoutpayment : SkinBase
	{
		ShoppingCart ShoppingCart { get; set; }

		GatewayProcessor GatewayProcessor { get; set; }

		string gateway = String.Empty;
		bool useLiveTransactions = false;
		bool RequireTerms = false;
		string SelectedPaymentType = String.Empty;
		string AllowedPaymentMethods = String.Empty;
		decimal CartTotal = Decimal.Zero;
		decimal NetTotal = Decimal.Zero;

		protected override void OnInit(EventArgs e)
		{
			ShoppingCart = new ShoppingCart(SkinID, ThisCustomer, CartTypeEnum.ShoppingCart, 0, false);
			if(ShoppingCart.HasCoupon())
			{
				string CouponCode = ShoppingCart.Coupon.CouponCode;
				ShoppingCart.ClearCoupon();
				ShoppingCart = new ShoppingCart(SkinID, ThisCustomer, CartTypeEnum.ShoppingCart, 0, false);
				ShoppingCart.SetCoupon(CouponCode, true);
				ctrlShoppingCart.DataSource = ShoppingCart.CartItems;
				ctrlShoppingCart.DataBind();
				ctrlCartSummary.DataSource = ShoppingCart;
				ctrlCartSummary.DataBind();
				InitializeOrderOptionControl();
			}
			else
			{
				ctrlShoppingCart.DataSource = ShoppingCart.CartItems;
				ctrlShoppingCart.DataBind();
				ctrlCartSummary.DataSource = ShoppingCart;
				InitializeOrderOptionControl();
			}

			// Set up CIM
			AspDotNetStorefrontGateways.Processors.AuthorizeNet authorizeNet = new AspDotNetStorefrontGateways.Processors.AuthorizeNet();
			// Need to set this here so it persists across loading viewstate
			ctrlCreditCardPanel.ShowCimSaveCard = authorizeNet.IsCimEnabled;

			base.OnInit(e);
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			if(DoPayPalRedirect())
				return;

			// Set up CIM
			AspDotNetStorefrontGateways.Processors.AuthorizeNet authorizeNet = new AspDotNetStorefrontGateways.Processors.AuthorizeNet();
			PanelWallet.Visible = authorizeNet.IsCimEnabled;

			if(!this.IsPostBack)
			{
				AspDotNetStorefrontCore.Customer.Current.ThisCustomerSession["ActivePaymentProfileId"] = String.Empty;
			}

			CimWalletSelector.PaymentProfileSelected += (o, l) =>
				{
					ctrlPaymentMethod.ClearSelection();
					ctrlPaymentMethod_OnPaymentMethodChanged(this, EventArgs.Empty);
				};

			// Set up discount
			if(ShoppingCart.HasCoupon())
			{
				string CouponName = ShoppingCart.Coupon.CouponCode;
				ShoppingCart.ClearCoupon();
				ShoppingCart = new ShoppingCart(SkinID, ThisCustomer, CartTypeEnum.ShoppingCart, 0, false);
				ShoppingCart.SetCoupon(CouponName, true);
			}

			Response.CacheControl = "private";
			Response.Expires = -1;
			Response.AddHeader("pragma", "no-cache");

			ErrorMessage err;
			if(AppLogic.AppConfigBool("RequireOver13Checked") && !ThisCustomer.IsOver13)
			{
				err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("checkout.over13required", ThisCustomer.SkinID, ThisCustomer.LocaleSetting)));
				Response.Redirect("shoppingcart.aspx?errormsg=" + err.MessageId);
			}

			RequireSecurePage();

			// -----------------------------------------------------------------------------------------------
			// NOTE ON PAGE LOAD LOGIC:
			// We are checking here for required elements to allowing the customer to stay on this page.
			// Many of these checks may be redundant, and they DO add a bit of overhead in terms of db calls, but ANYTHING really
			// could have changed since the customer was on the last page. Remember, the web is completely stateless. Assume this
			// page was executed by ANYONE at ANYTIME (even someone trying to break the cart). 
			// It could have been yesterday, or 1 second ago, and other customers could have purchased limitied inventory products, 
			// coupons may no longer be valid, etc, etc, etc...
			// -----------------------------------------------------------------------------------------------
			ThisCustomer.RequireCustomerRecord();
			String PM = AppLogic.CleanPaymentMethod(CommonLogic.QueryStringCanBeDangerousContent("PaymentMethod").Trim());

			if(!ThisCustomer.IsRegistered)
			{
				bool boolAllowAnon = (AppLogic.AppConfigBool("PasswordIsOptionalDuringCheckout") && !ShoppingCart.HasRecurringComponents());

				if(!boolAllowAnon && PM != "")
				{
					if(PM == AppLogic.ro_PMPayPalExpress || PM == AppLogic.ro_PMPayPalExpressMark)
					{
						boolAllowAnon = AppLogic.AppConfigBool("PayPal.Express.AllowAnonCheckout");
					}
				}

				if(!boolAllowAnon)
				{
					Response.Redirect("createaccount.aspx?checkout=true");
				}
			}
			if(ThisCustomer.PrimaryBillingAddressID == 0 || (ThisCustomer.PrimaryShippingAddressID == 0 && !AppLogic.AppConfigBool("SkipShippingOnCheckout") && !ShoppingCart.IsAllDownloadComponents() && !ShoppingCart.IsAllSystemComponents() && !ShoppingCart.NoShippingRequiredComponents() && !ShoppingCart.IsAllEmailGiftCards()))
			{
				err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("checkoutpayment.aspx.2", SkinID, ThisCustomer.LocaleSetting)));
				Response.Redirect("shoppingcart.aspx?resetlinkback=1&errormsg=" + err.MessageId);
			}

			SectionTitle = AppLogic.GetString("checkoutpayment.aspx.1", SkinID, ThisCustomer.LocaleSetting);

			if(ShoppingCart.CartItems.Count == 0)
			{
				Response.Redirect("shoppingcart.aspx");
			}

			// re-validate all shipping info, as ANYTHING could have changed since last page:
			if(!ShoppingCart.ShippingIsAllValid())
			{
				err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("shoppingcart.cs.95", ThisCustomer.SkinID, ThisCustomer.LocaleSetting)));
				HttpContext.Current.Response.Redirect("shoppingcart.aspx?resetlinkback=1&errormsg=" + err.MessageId);
			}

			gateway = AppLogic.ActivePaymentGatewayCleaned();
			GatewayProcessor = GatewayLoader.GetProcessor(gateway);
			useLiveTransactions = AppLogic.AppConfigBool("UseLiveTransactions");
			RequireTerms = AppLogic.AppConfigBool("RequireTermsAndConditionsAtCheckout");

			//HERE WE WILL DO THE LOOKUP for the new supported Shipping2Payment mapping
			if(AppLogic.AppConfigBool("UseMappingShipToPayment"))
			{
				try
				{
					int intCustomerSelectedShippingMethodID = ShoppingCart.FirstItem().ShippingMethodID;

					using(SqlConnection con = new SqlConnection(DB.GetDBConn()))
					{
						con.Open();
						using(IDataReader rsReferencePMForSelectedShippingMethod = DB.GetRS("SELECT MappedPM FROM ShippingMethod WHERE ShippingMethodID=" + intCustomerSelectedShippingMethodID.ToString(), con))
						{
							while(rsReferencePMForSelectedShippingMethod.Read())
							{
								AllowedPaymentMethods = DB.RSField(rsReferencePMForSelectedShippingMethod, "MappedPM").ToUpperInvariant();
							}
						}
					}

					if(AllowedPaymentMethods.Length <= 0)
					{
						AllowedPaymentMethods = AppLogic.AppConfig("PaymentMethods").ToUpperInvariant();
					}
				}
				catch
				{
					AllowedPaymentMethods = AppLogic.AppConfig("PaymentMethods").ToUpperInvariant();
				}
			}
			else
			{
				AllowedPaymentMethods = AppLogic.AppConfig("PaymentMethods").ToUpperInvariant();
				if(AppLogic.MicropayIsEnabled() && !ShoppingCart.HasSystemComponents())
				{
					if(AllowedPaymentMethods.Length != 0)
					{
						AllowedPaymentMethods += ",";
					}
					AllowedPaymentMethods += AppLogic.ro_PMMicropay;
				}
			}

			SelectedPaymentType = CommonLogic.IIF(SelectedPaymentType == "" && ThisCustomer.RequestedPaymentMethod != "" && AppLogic.CleanPaymentMethod(AllowedPaymentMethods).IndexOf(ThisCustomer.RequestedPaymentMethod, StringComparison.InvariantCultureIgnoreCase) != -1, AppLogic.CleanPaymentMethod(ThisCustomer.RequestedPaymentMethod), "");
			CartTotal = ShoppingCart.Total(true);
			NetTotal = CartTotal - CommonLogic.IIF(ShoppingCart.Coupon.CouponType == CouponTypeEnum.GiftCard, CommonLogic.IIF(CartTotal < ShoppingCart.Coupon.DiscountAmount, CartTotal, ShoppingCart.Coupon.DiscountAmount), 0);

			if(!this.IsPostBack)
			{
				InitializePageContent();
			}

			ibAmazonSimplePay.ImageUrl = AppLogic.AppConfig("AMAZON.ButtonURL");

			GatewayCheckoutByAmazon.CheckoutByAmazon checkoutByAmazon = new GatewayCheckoutByAmazon.CheckoutByAmazon();
			if(checkoutByAmazon.IsEnabled && checkoutByAmazon.IsCheckingOut)
			{
				ctrlPaymentMethod.Visible =
					pnlCCPane.Visible =
					pnlCCPaneInfo.Visible = false;
				PanelWallet.Visible = false;
			}

			AppLogic.eventHandler("CheckoutPayment").CallEvent("&CheckoutPayment=true");
		}

		protected void btnAmazonCheckout_Click(object sender, EventArgs e)
		{
			if(ctrlPaymentMethod.AMAZONSIMPLEPAYChecked)
			{
				ProcessPayment(AppLogic.ro_PMAmazonSimplePay);
			}
		}

		protected void btnContCheckout_Click(object sender, EventArgs e)
		{
			if(RequireTerms && CommonLogic.FormCanBeDangerousContent("TermsAndConditionsRead") == "")
			{
				bool bTermsRead = false;
				if(!bTermsRead)
				{
					pnlErrorMsg.Visible = true;
					ErrorMsgLabel.Text = Server.HtmlEncode(AppLogic.GetString("checkoutpayment.aspx.15", SkinID, ThisCustomer.LocaleSetting)).Replace("+", " ");
					return;
				}
			}

			GatewayCheckoutByAmazon.CheckoutByAmazon checkoutByAmazon = new GatewayCheckoutByAmazon.CheckoutByAmazon();
			if(checkoutByAmazon.IsEnabled && checkoutByAmazon.IsCheckingOut)
			{
				ProcessPayment(GatewayCheckoutByAmazon.CheckoutByAmazon.CBA_Gateway_Identifier);
			}
			else if(CimWalletSelector.SelectedPaymentProfileId != 0)
			{
				ProcessPayment(AppLogic.ro_PMCreditCard);
			}
			else if(ctrlPaymentMethod.CREDITCARDChecked)
			{
				Address BillingAddress = new Address();
				BillingAddress.LoadByCustomer(ThisCustomer.CustomerID, ThisCustomer.PrimaryBillingAddressID, AddressTypes.Billing);
				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMCreditCard;
				BillingAddress.UpdateDB();

				if(GatewayProcessor != null && !string.IsNullOrEmpty(GatewayProcessor.ProcessingPageRedirect()))
				{
					Response.Redirect(GatewayProcessor.ProcessingPageRedirect());
				}
				else
				{
					Page.Validate("creditcard");

					if(ctrlCreditCardPanel.CreditCardType == AppLogic.GetString("address.cs.32", SkinID, ThisCustomer.LocaleSetting))
					{
						pnlCCTypeErrorMsg.Visible = true;
					}
					else { pnlCCTypeErrorMsg.Visible = false; }
					if(ctrlCreditCardPanel.CardExpMonth == AppLogic.GetString("address.cs.34", SkinID, ThisCustomer.LocaleSetting) || ctrlCreditCardPanel.CardExpYr == AppLogic.GetString("address.cs.35", SkinID, ThisCustomer.LocaleSetting))
					{
						pnlCCExpDtErrorMsg.Visible = true;
					}
					else { pnlCCExpDtErrorMsg.Visible = false; }

					if(Page.IsValid && !(pnlCCTypeErrorMsg.Visible || pnlCCExpDtErrorMsg.Visible))
					{
						ProcessPayment(AppLogic.ro_PMCreditCard);
					}
				}
			}
			else if(ctrlPaymentMethod.PURCHASEORDERChecked)
			{
				ProcessPayment(AppLogic.ro_PMPurchaseOrder);
			}
			else if(ctrlPaymentMethod.CODMONEYORDERChecked)
			{
				ProcessPayment(AppLogic.ro_PMCODMoneyOrder);
			}
			else if(ctrlPaymentMethod.CODCOMPANYCHECKChecked)
			{
				ProcessPayment(AppLogic.ro_PMCODCompanyCheck);
			}
			else if(ctrlPaymentMethod.CODNET30Checked)
			{
				ProcessPayment(AppLogic.ro_PMCODNet30);
			}
			else if(ctrlPaymentMethod.PAYPALChecked)
			{
				Response.Redirect("paypalpane.aspx");
			}
			else if(ctrlPaymentMethod.REQUESTQUOTEChecked)
			{
				ProcessPayment(AppLogic.ro_PMRequestQuote);
			}
			else if(ctrlPaymentMethod.CHECKBYMAILChecked)
			{
				ProcessPayment(AppLogic.ro_PMCheckByMail);
			}
			else if(ctrlPaymentMethod.CODChecked)
			{
				ProcessPayment(AppLogic.ro_PMCOD);
			}
			else if(ctrlPaymentMethod.ECHECKChecked)
			{
				Page.Validate("echeck");
				if(Page.IsValid)
				{
					ProcessPayment(AppLogic.ro_PMECheck);
				}
			}
			else if(ctrlPaymentMethod.MICROPAYChecked)
			{
				ProcessPayment(AppLogic.ro_PMMicropay);
			}
			else if(ctrlPaymentMethod.PAYPALEXPRESSChecked)
			{
				ProcessPayment(AppLogic.ro_PMPayPalExpressMark);
			}
			else if(ctrlPaymentMethod.SECURENETVAULTChecked)
			{
				ProcessPayment(AppLogic.ro_PMSecureNetVault);
			}
		}

		protected void btnContinueCheckOut1_Click(object sender, EventArgs e)
		{
			ProcessPayment("CREDITCARD");
		}

		protected void ctrlPaymentMethod_OnPaymentMethodChanged(object sender, EventArgs e)
		{
			if(ctrlPaymentMethod.HasPaymentMethodSelected)
				CimWalletSelector.ClearSelection();

			WritePaymentPanels();
			pnlEcheckPane.Visible = ctrlPaymentMethod.ECHECKChecked;
			pnlPOPane.Visible = ctrlPaymentMethod.PURCHASEORDERChecked;
			pnlContCheckout.Visible = !ctrlPaymentMethod.AMAZONSIMPLEPAYChecked;
			pnlAmazonContCheckout.Visible = ctrlPaymentMethod.AMAZONSIMPLEPAYChecked;
			pnlSecureNetVaultPayment.Visible = ctrlPaymentMethod.SECURENETVAULTChecked;
			if(ctrlPaymentMethod.SECURENETVAULTChecked)
				SetupSecureNetVaultPayment();

			btnContCheckout.Visible = !pnlExternalPaymentMethod.Visible;
			SetCreditCardPanelVisibility(ctrlPaymentMethod.CREDITCARDChecked && !ctrlPaymentMethod.AMAZONSIMPLEPAYChecked);

			pnlSecureNetVaultPayment.Visible = ctrlPaymentMethod.SECURENETVAULTChecked;
			pnlPayPalEmbeddedCheckout.Visible = ctrlPaymentMethod.PAYPALEMBEDDEDCHECKOUTChecked;
			if(ctrlPaymentMethod.PAYPALEMBEDDEDCHECKOUTChecked)
				PreformPayPalEmbeddedCheckout();
		}

		void InitializePageContent()
		{
			JSPopupRoutines.Text = AppLogic.GetJSPopupRoutines();

			// Set credit card pane to be visible if that payment method is allowed, and no other payment method
			// is trying to be shown: If UseMappingShipToPayment is not activated Credit Card will always be
			// the default payment option that shows expnanded to the customer.
			if(AppLogic.AppConfigBool("UseMappingShipToPayment"))
			{
				string[] strSplittedCurrentMappingsInDB = AllowedPaymentMethods.Split(new char[] { ',' });

				String PM = AppLogic.CleanPaymentMethod(strSplittedCurrentMappingsInDB[0]);
				if(PM == AppLogic.ro_PMMicropay)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMMicropay) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMMicropay;
					}
				}
				else if(PM == AppLogic.ro_PMPurchaseOrder)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMPurchaseOrder) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMPurchaseOrder;
					}
				}
				else if(PM == AppLogic.ro_PMCreditCard)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMCreditCard) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMCreditCard;
					}
				}
				else if(PM == AppLogic.ro_PMPayPal)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMPayPal) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMPayPal;
					}
				}
				else if(PM == AppLogic.ro_PMPayPalExpressMark)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMPayPalExpressMark) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMPayPalExpressMark;
					}
				}
				else if(PM == AppLogic.ro_PMCOD)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMCOD) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMCOD;
					}
				}
				else if(PM == AppLogic.ro_PMECheck)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMECheck) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMECheck;
					}
				}
				else if(PM == AppLogic.ro_PMCheckByMail)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMCheckByMail) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMCheckByMail;
					}
				}
				else if(PM == AppLogic.ro_PMRequestQuote)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMRequestQuote) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMRequestQuote;
					}
				}
				else if(PM == AppLogic.ro_PMCODNet30)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMCODNet30) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMCODNet30;
					}
				}
				else if(PM == AppLogic.ro_PMCODCompanyCheck)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMCODCompanyCheck) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMCODCompanyCheck;
					}
				}
				else if(PM == AppLogic.ro_PMCODMoneyOrder)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMCODMoneyOrder) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMCODMoneyOrder;
					}
				}
				else if(PM == AppLogic.ro_PMAmazonSimplePay)
				{
					if(SelectedPaymentType.Length == 0 && AllowedPaymentMethods.IndexOf(AppLogic.ro_PMAmazonSimplePay) != -1)
					{
						SelectedPaymentType = AppLogic.ro_PMAmazonSimplePay;
					}
				}
			}

			bool useLiveTransactions = AppLogic.AppConfigBool("UseLiveTransactions");

			if(CommonLogic.QueryStringNativeInt("ErrorMsg") > 0)
			{
				ErrorMessage e = new ErrorMessage(CommonLogic.QueryStringNativeInt("ErrorMsg"));
				pnlErrorMsg.Visible = true;
				ErrorMsgLabel.Text = Server.HtmlDecode(e.Message);
			}

			String XmlPackageName = AppLogic.AppConfig("XmlPackage.CheckoutPaymentPageHeader");
			if(XmlPackageName.Length != 0)
			{
				XmlPackage_CheckoutPaymentPageHeader.Text = AppLogic.RunXmlPackage(XmlPackageName, base.GetParser, ThisCustomer, SkinID, String.Empty, String.Empty, true, true);
			}

			if(NetTotal == System.Decimal.Zero && AppLogic.AppConfigBool("SkipPaymentEntryOnZeroDollarCheckout"))
			{
				NoPaymentRequired.Text = AppLogic.GetString("checkoutpayment.aspx.28", SkinID, ThisCustomer.LocaleSetting);
				pnlNoPaymentRequired.Visible = true;
				pnlPaymentOptions.Visible = false;
				if(RequireTerms)
				{
					StringBuilder s = new StringBuilder("");
					s.Append(AppLogic.GetCheckoutTermsAndConditions(SkinID, ThisCustomer.LocaleSetting, base.GetParser, false));
					NoPaymentRequired.Text = NoPaymentRequired.Text + "<br><br>" + s.ToString();  //Cannot concat types String and StringBuilder in VB
					pnlRequireTerms.Visible = false;
				}
			}


			WritePaymentPanels();

			OrderSummary.Text = ShoppingCart.DisplaySummary(true, true, true, true, false);
			AppLogic.GetButtonDisable(btnContinueCheckOut1);
		}

		void InitializeOrderOptionControl()
		{
			ctrlOrderOption.ThisCustomer = ThisCustomer;
			ctrlOrderOption.EditMode = false;
			ctrlOrderOption.Datasource = ShoppingCart;

			if(ShoppingCart.OrderOptions.Count > 0)
			{
				ctrlOrderOption.DataBind();
				ctrlOrderOption.Visible = true;
			}
			else
			{
				ctrlOrderOption.Visible = false;
			}
		}

		void ProcessPostEvent(string paymentMethod)
		{
			Address BillingAddress = new Address();
			BillingAddress.LoadByCustomer(ThisCustomer.CustomerID, ThisCustomer.PrimaryBillingAddressID, AddressTypes.Billing);
			BillingAddress.PaymentMethodLastUsed = paymentMethod;
			BillingAddress.UpdateDB();
			OrderSummary.Text = ShoppingCart.DisplaySummary(true, true, true, true, false);
		}

		bool DoPayPalRedirect()
		{
			if (CommonLogic.QueryStringNativeInt("ErrorMsg") == 0)
				return false;

			var errorMessage = new ErrorMessage(CommonLogic.QueryStringNativeInt("ErrorMsg"));
			if(errorMessage.Message == AppLogic.ro_PMPayPalExpressRedirect)
			{
				Response.Redirect(PayPalController.GetECFaultRedirect(ThisCustomer));
				return true;
			}
			else
				return false;
		}

		void SetCreditCardPanelVisibility(Boolean visible)
		{
			if(!visible)
			{
				pnlCCPane.Visible = CCPaneInfo.Visible = false;
				return;
			}

			if(NetTotal == System.Decimal.Zero && AppLogic.AppConfigBool("SkipPaymentEntryOnZeroDollarCheckout"))
			{
				pnlPaymentOptions.Visible = pnlContCheckout.Visible = false;
				return;
			}

			pnlCCPane.Visible = true;
			pnlCCPaneInfo.Visible = false;

			string ccPaneData = GatewayProcessor == null ? null : GatewayProcessor.CreditCardPaneInfo(SkinID, ThisCustomer);
			GatewayCheckoutByAmazon.CheckoutByAmazon checkoutByAmazon = new GatewayCheckoutByAmazon.CheckoutByAmazon();

			if(!string.IsNullOrEmpty(ccPaneData))
			{
				CCPaneInfo.Text = ccPaneData;
				CCPaneInfo.Visible = true;
				//Make sure we don't hide the continue checkout button when checking out with amazon.  
				//CCPane might be selected because that was the last payment used by this customer.
				btnContCheckout.Visible = GatewayProcessor.ShowCheckoutButton || checkoutByAmazon.IsCheckingOut;
				pnlCCPane.Visible = false;
				pnlCCPaneInfo.Visible = true;
			}
			else
			{
				pnlCCPaneInfo.Visible = false;
				pnlCCPane.Visible = true;
			}
		}

		void WritePaymentPanels()
		{
			// When PAYPALPRO is active Gateway or PAYPALEXPRESS is available Payment Method
			// then we want to make the PayPal Express Mark available
			if((AppLogic.ActivePaymentGatewayCleaned() == Gateway.ro_GWPAYPALPRO || AllowedPaymentMethods.IndexOf(AppLogic.ro_PMPayPalExpress) > -1)
				&& AllowedPaymentMethods.IndexOf(AppLogic.ro_PMPayPalExpressMark) == -1)
			{
				if(AllowedPaymentMethods.Length != 0)
				{
					AllowedPaymentMethods += ",";
				}
				AllowedPaymentMethods += AppLogic.ro_PMPayPalExpressMark;
			}

			if(AppLogic.SecureNetVaultIsEnabled() && !ShoppingCart.HasRecurringComponents() && !ShoppingCart.ContainsRecurring() && !ShoppingCart.IsEmpty())
			{
				try
				{
					List<CustomerVaultPayment> ds = SecureNetDataReport.GetCustomerVault(ThisCustomer.CustomerID).SavedPayments;
					if(ds.Count > 0)
					{
						if(AllowedPaymentMethods.Length != 0)
						{
							AllowedPaymentMethods += ",";
						}
						AllowedPaymentMethods += AppLogic.ro_PMSecureNetVault;
					}
				}
				catch { }
			}



			Address BillingAddress = new Address();
			BillingAddress.LoadByCustomer(ThisCustomer.CustomerID, ThisCustomer.PrimaryBillingAddressID, AddressTypes.Billing);
			bool EChecksAllowed = GatewayProcessor != null && GatewayProcessor.SupportsEChecks(); // let manual gw use echecks so site testing can occur
			bool POAllowed = AppLogic.CustomerLevelAllowsPO(ThisCustomer.CustomerLevelID);
			bool CODCompanyCheckAllowed = ThisCustomer.CODCompanyCheckAllowed;
			bool CODNet30Allowed = ThisCustomer.CODNet30Allowed;

			StringBuilder OrderFinalizationInstructions = new StringBuilder(4096);
			String OrderFinalizationXmlPackageName = AppLogic.AppConfig("XmlPackage.OrderFinalization");
			String OrderFinalizationXmlPackageFN = Server.MapPath("xmlpackages/" + OrderFinalizationXmlPackageName);

			if(CommonLogic.FileExists(OrderFinalizationXmlPackageFN))
			{
				OrderFinalizationInstructions.Append("<p align=\"left\"><b>" + AppLogic.GetString("checkoutreview.aspx.24", SkinID, ThisCustomer.LocaleSetting) + "</b></p>");
				OrderFinalizationInstructions.Append(AppLogic.RunXmlPackage(OrderFinalizationXmlPackageName, null, ThisCustomer, SkinID, string.Empty, string.Empty, false, false));
			}
			if(OrderFinalizationInstructions.Length != 0)
			{
				OrderFinalizationInstructions.Append("");
			}
			Finalization.Text = OrderFinalizationInstructions.ToString(); // set the no payment panel here, in case it is needed

			bool check = AllowedPaymentMethods.Split(',').Length <= 1;

			//If checkout by amazon we don't want to show normal payment methods
			GatewayCheckoutByAmazon.CheckoutByAmazon checkoutByAmazon = new GatewayCheckoutByAmazon.CheckoutByAmazon();
			if(!(checkoutByAmazon.IsEnabled && checkoutByAmazon.IsCheckingOut))
			{

				foreach(String PM in AllowedPaymentMethods.Split(','))
				{
					String PMCleaned = AppLogic.CleanPaymentMethod(PM);
					if(PMCleaned == AppLogic.ro_PMCreditCard)
					{
						pnlFinalization.Visible = Finalization.Text.Length != 0;
						PMFinalization.Text = OrderFinalizationInstructions.ToString();

						if(!IsPostBack)
						{
							ctrlPaymentMethod.CREDITCARDChecked = ((BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMCreditCard) || (BillingAddress.PaymentMethodLastUsed.Trim().Length <= 0 || check));
							SetCreditCardPanelVisibility(((BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMCreditCard) || (BillingAddress.PaymentMethodLastUsed.Trim().Length <= 0)));

							// Display only non-CIM entries
							if(!(BillingAddress.CardNumber.StartsWith("****") && AppLogic.GetCardExtraCodeFromSession(ThisCustomer) == "NA"))
							{
								if(ctrlCreditCardPanel.CreditCardName == "")
								{
									ctrlCreditCardPanel.CreditCardName = BillingAddress.CardName;
								}
								if(ctrlCreditCardPanel.CreditCardNumber == "")
								{
									ctrlCreditCardPanel.CreditCardNumber = AppLogic.SafeDisplayCardNumber(BillingAddress.CardNumber, "Address", BillingAddress.AddressID);
								}
								if(ctrlCreditCardPanel.CreditCardVerCd == "")
								{
									ctrlCreditCardPanel.CreditCardVerCd = AppLogic.SafeDisplayCardExtraCode(AppLogic.GetCardExtraCodeFromSession(ThisCustomer));
								}
								if(ctrlCreditCardPanel.CreditCardType == AppLogic.GetString("address.cs.32", SkinID, ThisCustomer.LocaleSetting))
								{
									ctrlCreditCardPanel.CreditCardType = BillingAddress.CardType;
								}
								if(ctrlCreditCardPanel.CardExpMonth == AppLogic.GetString("address.cs.34", SkinID, ThisCustomer.LocaleSetting))
								{
									ctrlCreditCardPanel.CardExpMonth = BillingAddress.CardExpirationMonth;
								}
								if(ctrlCreditCardPanel.CardExpYr == AppLogic.GetString("address.cs.35", SkinID, ThisCustomer.LocaleSetting))
								{
									ctrlCreditCardPanel.CardExpYr = BillingAddress.CardExpirationYear;
								}
								if(!CommonLogic.IsStringNullOrEmpty(BillingAddress.CardStartDate))
								{
									if(ctrlCreditCardPanel.CardStartMonth == AppLogic.GetString("address.cs.34", SkinID, ThisCustomer.LocaleSetting))
									{
										ctrlCreditCardPanel.CardStartMonth = BillingAddress.CardStartDate.Substring(0, 2);
									}
									if(ctrlCreditCardPanel.CardStartYear == AppLogic.GetString("address.cs.35", SkinID, ThisCustomer.LocaleSetting))
									{
										ctrlCreditCardPanel.CardStartYear = BillingAddress.CardStartDate.Substring(2, 4);
									}
								}
								if(ctrlCreditCardPanel.CreditCardIssueNumber == "")
								{
									ctrlCreditCardPanel.CreditCardIssueNumber = BillingAddress.CardIssueNumber;
								}
							}
						}

						ctrlPaymentMethod.ShowCREDITCARD = true;
					}
					else if(PMCleaned == AppLogic.ro_PMPurchaseOrder)
					{
						if(POAllowed)
						{
							ctrlPaymentMethod.ShowPURCHASEORDER = true;
							PMFinalization.Text = OrderFinalizationInstructions.ToString();
							pnlFinalization.Visible = Finalization.Text.Length != 0;

							if(!IsPostBack)
							{
								ctrlPaymentMethod.PURCHASEORDERChecked = ((BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMPurchaseOrder) || check);
								pnlPOPane.Visible = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMPurchaseOrder || check);
							}

							if(txtPO.Text == "")
							{
								txtPO.Text = BillingAddress.PONumber;
							}
						}
					}
					else if(PMCleaned == AppLogic.ro_PMCODMoneyOrder)
					{
						ctrlPaymentMethod.ShowCODMONEYORDER = true;
						PMFinalization.Text = OrderFinalizationInstructions.ToString();
						pnlFinalization.Visible = Finalization.Text.Length != 0;

						if(!IsPostBack)
						{
							ctrlPaymentMethod.CODMONEYORDERChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMCODMoneyOrder || check);
						}
					}
					else if(PMCleaned == AppLogic.ro_PMCODCompanyCheck)
					{
						if(CODCompanyCheckAllowed)
						{
							ctrlPaymentMethod.ShowCODCOMPANYCHECK = true;
							PMFinalization.Text = OrderFinalizationInstructions.ToString();
							pnlFinalization.Visible = Finalization.Text.Length != 0;

							if(!IsPostBack)
							{
								ctrlPaymentMethod.CODCOMPANYCHECKChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMCODCompanyCheck || check);
								pnlPOPane.Visible = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMCODCompanyCheck || check);
							}

							if(txtPO.Text == "")
							{
								txtPO.Text = BillingAddress.PONumber;
							}
						}
					}
					else if(PMCleaned == AppLogic.ro_PMCODNet30)
					{
						if(CODNet30Allowed)
						{
							ctrlPaymentMethod.ShowCODNET30 = true;
							PMFinalization.Text = OrderFinalizationInstructions.ToString();
							pnlFinalization.Visible = Finalization.Text.Length != 0;

							if(!IsPostBack)
							{
								ctrlPaymentMethod.PAYPALChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMCODNet30 || check);
								pnlPOPane.Visible = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMCODNet30 || check);
							}

							if(txtPO.Text == "")
							{
								txtPO.Text = BillingAddress.PONumber;
							}
						}
					}
					else if(PMCleaned == AppLogic.ro_PMAmazonSimplePay)
					{
						ctrlPaymentMethod.ShowAmazonSimplePay = true;

						if(!IsPostBack)
						{
							ctrlPaymentMethod.AMAZONSIMPLEPAYChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMAmazonSimplePay || check);
						}
					}
					else if(PMCleaned == AppLogic.ro_PMPayPal)
					{
						ctrlPaymentMethod.ShowPAYPAL = true;

						if(!IsPostBack)
						{
							ctrlPaymentMethod.PAYPALChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMPayPal || check);
						}
					}
					else if(PMCleaned == AppLogic.ro_PMPayPalExpressMark)
					{
						if(!ShoppingCart.IsEmpty())
						{
							ctrlPaymentMethod.ShowPAYPALEXPRESS = true;
							PMFinalization.Text = OrderFinalizationInstructions.ToString();
							pnlFinalization.Visible = Finalization.Text.Length != 0;

							if(!IsPostBack)
							{
								ctrlPaymentMethod.PAYPALEXPRESSChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMPayPalExpress || check);
							}
						}

					}
					else if(PMCleaned == AppLogic.ro_PMRequestQuote)
					{
						ctrlPaymentMethod.ShowREQUESTQUOTE = true;
						PMFinalization.Text = OrderFinalizationInstructions.ToString();
						pnlFinalization.Visible = Finalization.Text.Length != 0;

						if(!IsPostBack)
						{
							ctrlPaymentMethod.REQUESTQUOTEChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMRequestQuote || check);
						}
					}
					else if(PMCleaned == AppLogic.ro_PMCheckByMail)
					{
						ctrlPaymentMethod.ShowCHECKBYMAIL = true;
						PMFinalization.Text = OrderFinalizationInstructions.ToString();
						pnlFinalization.Visible = Finalization.Text.Length != 0;

						if(!IsPostBack)
						{
							ctrlPaymentMethod.CHECKBYMAILChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMCheckByMail || check);
						}
					}
					else if(PMCleaned == AppLogic.ro_PMCOD)
					{
						ctrlPaymentMethod.ShowCOD = true;
						PMFinalization.Text = OrderFinalizationInstructions.ToString();
						pnlFinalization.Visible = Finalization.Text.Length != 0;

						if(!IsPostBack)
						{
							ctrlPaymentMethod.CODChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMCOD || check);
						}
					}
					else if(PMCleaned == AppLogic.ro_PMECheck)
					{
						if(EChecksAllowed)
						{
							pnlFinalization.Visible = Finalization.Text.Length != 0;
							ctrlEcheck.ECheckBankABAImage1 = AppLogic.LocateImageURL("~/App_Themes/skin_" + SkinID.ToString() + "/images/check_aba.gif");
							ctrlEcheck.ECheckBankABAImage2 = AppLogic.LocateImageURL("~/App_Themes/skin_" + SkinID.ToString() + "/images/check_aba.gif");
							ctrlEcheck.ECheckBankAccountImage = AppLogic.LocateImageURL("~/App_Themes/skin_" + SkinID.ToString() + "/images/check_account.gif");
							ctrlEcheck.ECheckNoteLabel = string.Format(AppLogic.GetString("address.cs.48", SkinID, ThisCustomer.LocaleSetting), AppLogic.LocateImageURL("App_Themes/skin_" + SkinID.ToString() + "/images/check_micr.gif"));

							if(!IsPostBack)
							{
								ctrlPaymentMethod.ECHECKChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMECheck || check);
								pnlEcheckPane.Visible = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMECheck || check);

								if(ctrlEcheck.ECheckBankAccountName == "")
								{
									ctrlEcheck.ECheckBankAccountName = BillingAddress.ECheckBankAccountName;
								}
								if(ctrlEcheck.ECheckBankName == "")
								{
									ctrlEcheck.ECheckBankName = BillingAddress.ECheckBankName;
								}
								if(ctrlEcheck.ECheckBankABACode == "")
								{
									ctrlEcheck.ECheckBankABACode = AppLogic.SafeDisplayCardNumber(BillingAddress.ECheckBankABACode, "Address", BillingAddress.AddressID);
								}
								if(ctrlEcheck.ECheckBankAccountNumber == "")
								{
									ctrlEcheck.ECheckBankAccountNumber = AppLogic.SafeDisplayCardNumber(BillingAddress.ECheckBankAccountNumber, "Address", BillingAddress.AddressID);
								}
							}

							ctrlPaymentMethod.ShowECHECK = true;

						}
					}
					else if(PMCleaned == AppLogic.ro_PMMicropay)
					{
						if(AppLogic.MicropayIsEnabled())
						{
							ctrlPaymentMethod.ShowMICROPAY = true;

							if(ctrlPaymentMethod.MICROPAYChecked)
							{
								PMFinalization.Text = OrderFinalizationInstructions.ToString();
								pnlFinalization.Visible = (ThisCustomer.MicroPayBalance >= NetTotal && PMFinalization.Text.Length != 0);
								btnContCheckout.Visible = ThisCustomer.MicroPayBalance >= NetTotal;
								ctrlPaymentMethod.ShowMICROPAYMessage = ThisCustomer.MicroPayBalance < NetTotal;
								ctrlPaymentMethod.MICROPAYLabel = String.Format(AppLogic.GetString("checkoutpayment.aspx.26", SkinID, ThisCustomer.LocaleSetting), ThisCustomer.CurrencyString(ThisCustomer.MicroPayBalance));
							}
							else
							{
								btnContCheckout.Visible = true;
								ctrlPaymentMethod.ShowMICROPAYMessage = false;
							}

							if(!IsPostBack)
							{
								ctrlPaymentMethod.MICROPAYChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMMicropay || check);
							}
						}
					}
					else if(PMCleaned == AppLogic.ro_PMPayPalEmbeddedCheckout)
					{
						ctrlPaymentMethod.ShowPAYPALEMBEDDEDCHECKOUT = true;

						PMFinalization.Text = OrderFinalizationInstructions.ToString();
						pnlFinalization.Visible = Finalization.Text.Length != 0;

						if(!IsPostBack)
						{
							ctrlPaymentMethod.PAYPALEMBEDDEDCHECKOUTChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMPayPalEmbeddedCheckout ||
								BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMPayPalExpress ||
								BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMPayPalExpressMark ||
								BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMPayPal || check);
						}
					}
					else if(PMCleaned == AppLogic.ro_PMSecureNetVault)
					{
						ctrlPaymentMethod.ShowSECURENETVAULT = true;

						PMFinalization.Text = OrderFinalizationInstructions.ToString();
						pnlFinalization.Visible = Finalization.Text.Length != 0;

						if(!IsPostBack)
						{
							ctrlPaymentMethod.SECURENETVAULTChecked = (BillingAddress.PaymentMethodLastUsed == AppLogic.ro_PMSecureNetVault || check);
						}
					}
					RequireTermsandConditions.Text = AppLogic.GetCheckoutTermsAndConditions(SkinID, ThisCustomer.LocaleSetting, base.GetParser, false);
				}


				if(ctrlPaymentMethod.ShowCREDITCARD && ctrlPaymentMethod.ShowPAYPALEMBEDDEDCHECKOUT)
				{
					if(ctrlPaymentMethod.CREDITCARDChecked)
						ctrlPaymentMethod.PAYPALEMBEDDEDCHECKOUTChecked = true;
					ctrlPaymentMethod.ShowCREDITCARD = ctrlPaymentMethod.CREDITCARDChecked = false;
				}

			}

			SetCreditCardPanelVisibility(ctrlPaymentMethod.CREDITCARDChecked);

			pnlEcheckPane.Visible = ctrlPaymentMethod.ECHECKChecked;
			pnlPOPane.Visible = ctrlPaymentMethod.PURCHASEORDERChecked;

			if(!IsPostBack && ctrlPaymentMethod.SECURENETVAULTChecked)
			{
				pnlSecureNetVaultPayment.Visible = true;
				SetupSecureNetVaultPayment();
			}

			if(!IsPostBack && ctrlPaymentMethod.PAYPALEMBEDDEDCHECKOUTChecked)
			{
				pnlPayPalEmbeddedCheckout.Visible = true;
				PreformPayPalEmbeddedCheckout();
			}

			if(ErrorMsgLabel.Text.Length <= 0)
			{
				pnlErrorMsg.Visible = false;
			}

			Boolean GWRequiresFinalization = GatewayProcessor != null && GatewayProcessor.RequiresFinalization();

			if(
					ctrlPaymentMethod.PAYPALChecked ||
					(ThisCustomer.MicroPayBalance < NetTotal && ctrlPaymentMethod.MICROPAYChecked) ||
					(ctrlPaymentMethod.CREDITCARDChecked && GWRequiresFinalization)
				)
			{
				pnlFinalization.Visible = false;
			}


			if(ctrlPaymentMethod.CREDITCARDChecked)
			{
				SetCreditCardPanelVisibility(true);
			}
			else
			{
				pnlCCPaneInfo.Visible = false;
			}
		}

		void PreformPayPalEmbeddedCheckout()
		{
			btnContCheckout.Visible = false;
			string returnUrl = string.Format("{0}fp-paypalembeddedcheckoutok.aspx", AppLogic.GetStoreHTTPLocation(true));
			string errorUrl = string.Format("{0}fp-paypalembeddedcheckoutok.aspx", AppLogic.GetStoreHTTPLocation(true));
			string cancelUrl = string.Format("{0}fp-checkoutpayment.aspx", AppLogic.GetStoreHTTPLocation(true));
			string notifyUrl = string.Format("{0}paypalnotification.aspx", AppLogic.GetStoreHTTPLocation(true));
			string silentPostURL = string.Format("{0}paypalembeddedcheckoutok.aspx", AppLogic.GetStoreHTTPLocation(true));
			PayPalEmbeddedCheckoutSecureTokenResponse response = PayFlowProController.GetFramedHostedCheckout(ShoppingCart, ThisCustomer.PrimaryShippingAddress, returnUrl, errorUrl, cancelUrl, notifyUrl, silentPostURL);

			if(response.Result != 0)
				throw new Exception(AppLogic.GetString("paypalpaymentsadvanced.configerror", ThisCustomer.LocaleSetting));

			Session["PayPalEmbeddedCheckoutSecureToken"] = response.SecureToken;
			Session["PayPalEmbeddedCheckoutSecureTokenId"] = response.SecureTokenID;

			string frameSrc = response.GetFrameSrc(0, 400);
			litPayPalEmbeddedCheckoutFrame.Text = frameSrc;
		}

		void ProcessPayment(string paymentMethod)
		{
			if(NetTotal > System.Decimal.Zero || !AppLogic.AppConfigBool("SkipPaymentEntryOnZeroDollarCheckout"))
			{
				AppLogic.ValidatePM(CommonLogic.QueryStringCanBeDangerousContent("PaymentMethod")); // this WILL throw a hard security exception on any problem!
			}
			String PM = AppLogic.CleanPaymentMethod(paymentMethod);

			ProcessPostEvent(PM);

			if(!ThisCustomer.IsRegistered)
			{
				bool boolAllowAnon = (AppLogic.AppConfigBool("PasswordIsOptionalDuringCheckout") && !ShoppingCart.HasRecurringComponents());

				if(!boolAllowAnon && (paymentMethod == AppLogic.ro_PMPayPalExpress || paymentMethod == AppLogic.ro_PMPayPalExpressMark))
				{
					boolAllowAnon = AppLogic.AppConfigBool("PayPal.Express.AllowAnonCheckout");
				}

				if(!boolAllowAnon)
				{
					Response.Redirect("createaccount.aspx?checkout=true");
				}
			}

			ErrorMessage err;
			if(ThisCustomer.PrimaryBillingAddressID == 0 || ThisCustomer.PrimaryShippingAddressID == 0)
			{
				err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("checkoutpayment.aspx.2", SkinID, ThisCustomer.LocaleSetting)));
				Response.Redirect("shoppingcart.aspx?resetlinkback=1&errormsg=" + err.MessageId);
			}

			if(ShoppingCart.IsEmpty())
			{
				Response.Redirect("shoppingcart.aspx?resetlinkback=1");
			}

			if(ShoppingCart.InventoryTrimmed)
			{
				err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("shoppingcart.aspx.3", SkinID, ThisCustomer.LocaleSetting)));
				Response.Redirect("shoppingcart.aspx?resetlinkback=1&errormsg=" + err.MessageId);
			}

			if(ShoppingCart.RecurringScheduleConflict)
			{
				err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("shoppingcart.aspx.19", SkinID, ThisCustomer.LocaleSetting)));
				Response.Redirect("shoppingcart.aspx?resetlinkback=1&errormsg=" + err.MessageId);
			}

			if(ShoppingCart.HasCoupon() && !ShoppingCart.CouponIsValid)
			{
				Response.Redirect("shoppingcart.aspx?resetlinkback=1&discountvalid=false");
			}

			if(!ShoppingCart.MeetsMinimumOrderAmount(AppLogic.AppConfigUSDecimal("CartMinOrderAmount")))
			{
				Response.Redirect("shoppingcart.aspx?resetlinkback=1");
			}

			if(!ShoppingCart.MeetsMinimumOrderQuantity(AppLogic.AppConfigUSInt("MinCartItemsBeforeCheckout")))
			{
				Response.Redirect("shoppingcart.aspx?resetlinkback=1");
			}

			if(ShoppingCart.ExceedsMaximumOrderQuantity(AppLogic.AppConfigUSInt("MaxCartItemsBeforeCheckout")))
			{
				Response.Redirect("shoppingcart.aspx?resetlinkback=1");
			}

			// re-validate all shipping info, as ANYTHING could have changed since last page:
			if(!ShoppingCart.ShippingIsAllValid())
			{
				err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("shoppingcart.cs.95", ThisCustomer.SkinID, ThisCustomer.LocaleSetting)));
				HttpContext.Current.Response.Redirect("shoppingcart.aspx?resetlinkback=1&errormsg=" + err.MessageId);
			}

			Address BillingAddress = new Address();
			BillingAddress.LoadByCustomer(ThisCustomer.CustomerID, ThisCustomer.PrimaryBillingAddressID, AddressTypes.Billing);

			// ----------------------------------------------------------------
			// Get the finalization info (if any):
			// ----------------------------------------------------------------
			StringBuilder FinalizationXml = new StringBuilder(4096);
			FinalizationXml.Append("<root>");
			for(int i = 0; i < Request.Form.Count; i++)
			{
				String FieldName = Request.Form.Keys[i];
				String FieldVal = Request.Form[Request.Form.Keys[i]].Trim();
				if(FieldName != null && FieldName.StartsWith("finalization", StringComparison.InvariantCultureIgnoreCase) && !FieldName.EndsWith("_vldt", StringComparison.InvariantCultureIgnoreCase))
				{
					FinalizationXml.Append("<field>");
					FinalizationXml.Append("<" + XmlCommon.XmlEncode(FieldName) + ">");
					FinalizationXml.Append(XmlCommon.XmlEncode(FieldVal));
					FinalizationXml.Append("</" + XmlCommon.XmlEncode(FieldName) + ">");
					FinalizationXml.Append("</field>");
				}
			}
			FinalizationXml.Append("</root>");
			DB.ExecuteSQL(String.Format("update customer set FinalizationData={0} where CustomerID={1}", DB.SQuote(FinalizationXml.ToString()), ThisCustomer.CustomerID.ToString()));

			// ----------------------------------------------------------------
			// Store the payment info (if required):
			// ----------------------------------------------------------------
			if(paymentMethod.Length == 0)
			{
				err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("checkoutpayment.aspx.20", ThisCustomer.SkinID, ThisCustomer.LocaleSetting)));
				Response.Redirect("checkoutpayment.aspx?errormsg=" + err.MessageId);
			}
			if(PM.StartsWith(AppLogic.ro_PMCreditCard))
			{
				String CardName = ctrlCreditCardPanel.CreditCardName.Trim();
				String CardNumber = ctrlCreditCardPanel.CreditCardNumber.Trim().Replace(" ", "");
				String CardExtraCode = ctrlCreditCardPanel.CreditCardVerCd.Trim().Replace(" ", "");
				String strCardType = ctrlCreditCardPanel.CreditCardType.Trim();
				String CardExpirationMonth = ctrlCreditCardPanel.CardExpMonth.Trim().Replace(" ", "");
				String CardExpirationYear = ctrlCreditCardPanel.CardExpYr.Trim().Replace(" ", "");

				String CardStartDate = ctrlCreditCardPanel.CardStartMonth.Replace(" ", "").PadLeft(2, '0') + ctrlCreditCardPanel.CardStartYear.Trim().Replace(" ", "");
				String CardIssueNumber = ctrlCreditCardPanel.CreditCardIssueNumber.Trim().Replace(" ", "");

				// Save CIM payment profile id
				if(CimWalletSelector.SelectedPaymentProfileId > 0)
				{
					NetTotal = 1.0m;
					var paymentProfile = GatewayAuthorizeNet.DataUtility.GetPaymentProfileWrapper(ThisCustomer.CustomerID, ThisCustomer.EMail, CimWalletSelector.SelectedPaymentProfileId);
					CardNumber = paymentProfile.CreditCardNumberMasked;
					CardExpirationYear = paymentProfile.ExpirationYear;
					CardExpirationMonth = paymentProfile.ExpirationMonth;
					strCardType = paymentProfile.CardType;
					CardExtraCode = "NA";
				}

				if(CardNumber.StartsWith("*") && CimWalletSelector.SelectedPaymentProfileId <= 0)
				{
					// Still obscured in the form so use the original
					CardNumber = BillingAddress.CardNumber;
				}

				if(CardExtraCode.StartsWith("*"))
				{
					// Still obscured in the form so use the original
					CardExtraCode = AppLogic.GetCardExtraCodeFromSession(ThisCustomer);
				}

				if(AppLogic.AppConfigBool("ValidateCreditCardNumbers"))
				{
					BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMCreditCard;
					BillingAddress.CardName = CardName;
					BillingAddress.CardExpirationMonth = CardExpirationMonth;
					BillingAddress.CardExpirationYear = CardExpirationYear;
					BillingAddress.CardStartDate = CommonLogic.IIF((CardStartDate == "00" || !CommonLogic.IsNumber(CardStartDate)), String.Empty, CardStartDate);
					BillingAddress.CardIssueNumber = CardIssueNumber;

					CardType Type = CardType.Parse(strCardType);
					CreditCardValidator validator = new CreditCardValidator(CardNumber, Type);
					bool isValid = validator.Validate();

					BillingAddress.CardType = strCardType;
					if(!isValid)
					{
						CardNumber = string.Empty;
						// clear the card extra code
						AppLogic.StoreCardExtraCodeInSession(ThisCustomer, string.Empty);
					}
					BillingAddress.CardNumber = CardNumber;
					BillingAddress.UpdateDB();

					if(!isValid)
					{
						err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("checkoutcard_process.aspx.3", 1, Localization.GetDefaultLocale())));
						Response.Redirect("checkoutpayment.aspx?errormsg=" + err.MessageId);
					}

				}

				// store in appropriate session, encrypted, so it can be used when the order is actually "entered"
				AppLogic.StoreCardExtraCodeInSession(ThisCustomer, CardExtraCode);


				if(NetTotal == System.Decimal.Zero && AppLogic.AppConfigBool("SkipPaymentEntryOnZeroDollarCheckout"))
				{
					// remember their info:
					BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMCreditCard;
					BillingAddress.ClearCCInfo();
					BillingAddress.UpdateDB();
				}
				else
				{
					// remember their info:                    
					BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMCreditCard;
					BillingAddress.CardName = CardName;
					BillingAddress.CardType = strCardType;
					BillingAddress.CardNumber = CardNumber;
					BillingAddress.CardExpirationMonth = CardExpirationMonth;
					BillingAddress.CardExpirationYear = CardExpirationYear;
					BillingAddress.CardStartDate = CommonLogic.IIF((CardStartDate == "00" || !CommonLogic.IsNumber(CardStartDate)), String.Empty, CardStartDate);
					BillingAddress.CardIssueNumber = CardIssueNumber;
					BillingAddress.UpdateDB();

					if(CardNumber.Length == 0)
					{
						err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("checkoutcard_process.aspx.1", 1, Localization.GetDefaultLocale())));
						Response.Redirect("checkoutpayment.aspx?errormsg=" + err.MessageId);
					}
					if((!AppLogic.AppConfigBool("CardExtraCodeIsOptional") && CardExtraCode.Length == 0))
					{
						err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("checkoutcard_process.aspx.5", 1, Localization.GetDefaultLocale())));
						Response.Redirect("checkoutpayment.aspx?errormsg=" + err.MessageId);
					}

					// Save card to CIM if selected
					if(ctrlCreditCardPanel.CimSaveCard)
					{
						string errorMessage, errorCode;
						Int64 saveCardProfileId = 0;

						saveCardProfileId = GatewayAuthorizeNet.ProcessTools.SaveProfileAndPaymentProfile(
							ThisCustomer.CustomerID, ThisCustomer.EMail, AspDotNetStorefrontCore.AppLogic.AppConfig("StoreName"),
							saveCardProfileId, BillingAddress.AddressID, CardNumber, CardExtraCode, CardExpirationMonth, CardExpirationYear,
							out errorMessage, out errorCode);

						if(saveCardProfileId <= 0 && errorCode != "E00039")
						{
							err = new ErrorMessage(Server.HtmlEncode(errorMessage));
							Response.Redirect("checkoutpayment.aspx?errormsg=" + err.MessageId);
						}
					}
				}
			}
			else if(PM == AppLogic.ro_PMPurchaseOrder)
			{
				String PONumber = txtPO.Text.Trim();
				if(PONumber.Length == 0)
				{
					err = new ErrorMessage(Server.HtmlEncode(AppLogic.GetString("checkoutpayment.aspx.21", ThisCustomer.SkinID, ThisCustomer.LocaleSetting)));
					Response.Redirect("checkoutpayment.aspx?errormsg=" + err.MessageId);
				}

				// remember their info:
				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMPurchaseOrder;
				BillingAddress.PONumber = PONumber;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();
			}
			else if(PM == AppLogic.ro_PMCODMoneyOrder)
			{
				// remember their info:
				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMCODMoneyOrder;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();
			}
			else if(PM == AppLogic.ro_PMCODCompanyCheck)
			{
				// remember their info:
				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMCODCompanyCheck;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();
			}
			else if(PM == AppLogic.ro_PMCODNet30)
			{
				// remember their info:
				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMCODNet30;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();
			}
			else if(PM == AppLogic.ro_PMPayPal)
			{
				return; // They need to click the button on this page to get sent to paypal.com
			}
			else if(PM == AppLogic.ro_PMRequestQuote)
			{
				// no action required here
				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMRequestQuote;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();
			}
			else if(PM == AppLogic.ro_PMCheckByMail)
			{
				// no action required here
				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMCheckByMail;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();
			}
			else if(PM == AppLogic.ro_PMCOD)
			{
				// no action required here
				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMCOD;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();
			}
			else if(PM == AppLogic.ro_PMECheck)
			{
				string validFailureReason = string.Empty;
				if(!ctrlEcheck.Validate(out validFailureReason))
				{
					err = new ErrorMessage(Server.HtmlEncode(validFailureReason));
					Response.Redirect("checkoutpayment.aspx?errormsg=" + err.MessageId);
				}


				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMECheck;
				BillingAddress.ECheckBankName = ctrlEcheck.ECheckBankName;

				if(!ctrlEcheck.ECheckBankABACode.StartsWith("*"))
				{
					BillingAddress.ECheckBankABACode = ctrlEcheck.ECheckBankABACode;
				}

				if(!ctrlEcheck.ECheckBankAccountNumber.StartsWith("*"))
				{
					BillingAddress.ECheckBankAccountNumber = ctrlEcheck.ECheckBankAccountNumber;
				}

				BillingAddress.ECheckBankAccountType = ctrlEcheck.ECheckBankAccountType;
				BillingAddress.ECheckBankAccountName = ctrlEcheck.ECheckBankAccountName;
				BillingAddress.UpdateDB();
			}
			else if(PM == AppLogic.ro_PMMicropay)
			{
				BillingAddress.PaymentMethodLastUsed = AppLogic.ro_PMMicropay;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();
			}
			else if(PM == AppLogic.ro_PMPayPalExpress || PM == AppLogic.ro_PMPayPalExpressMark)
			{
				BillingAddress.PaymentMethodLastUsed = PM;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();

				Address shippingAddress = new Address();
				shippingAddress.LoadByCustomer(ThisCustomer.CustomerID, ThisCustomer.PrimaryShippingAddressID, AddressTypes.Shipping);
				String sURL = Gateway.StartExpressCheckout(ShoppingCart, shippingAddress, null);
				Response.Redirect(sURL);
			}
			else if(PM == AppLogic.ro_PMAmazonSimplePay)
			{
				BillingAddress.PaymentMethodLastUsed = PM;
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
				}
				BillingAddress.UpdateDB();

				Response.Redirect("amazonpane.aspx");
			}
			else if(PM == AppLogic.ro_PMSecureNetVault)
			{
				BillingAddress.PaymentMethodLastUsed = PM;
				if(rblSecureNetVaultMethods.SelectedIndex < 0)
				{
					lblSecureNetMessage.Text = "securenet.selectamethod".StringResource();
					lblSecureNetMessage.Visible = true;
					return;
				}
				AppLogic.StoreSelectedSecureNetVault(ThisCustomer, rblSecureNetVaultMethods.SelectedValue);
				if(!ThisCustomer.MasterShouldWeStoreCreditCardInfo)
				{
					BillingAddress.ClearCCInfo();
					BillingAddress.UpdateDB();
				}
			}

			Response.Redirect("checkoutreview.aspx?paymentmethod=" + Server.UrlEncode(paymentMethod));
		}

		void SetupSecureNetVaultPayment()
		{
			if(AppLogic.SecureNetVaultIsEnabled())
			{
				if(rblSecureNetVaultMethods.Items.Count == 0)
				{
					List<CustomerVaultPayment> ds = SecureNetDataReport.GetCustomerVault(ThisCustomer.CustomerID).SavedPayments;
					rblSecureNetVaultMethods.Items.Clear();
					foreach(CustomerVaultPayment payment in ds)
					{
						String rbText = String.Format("<strong>{0}</strong>: {1} <strong>{2}</strong>: {3}", "account.creditcardprompt".StringResource(), payment.CardNumberPadded, "account.expires".StringResource(), payment.ExpDateFormatted);
						String rbValue = payment.PaymentId;
						ListItem add = new ListItem(rbText, rbValue);
						add.Selected = (rbValue == AppLogic.GetSelectedSecureNetVault(ThisCustomer));
						rblSecureNetVaultMethods.Items.Add(add);
					}
					if(ds.Count == 0)
					{
						lblSecureNetMessage.Text = "securenet.nosavedmethods".StringResource();
					}
				}
			}
		}
	}
}
