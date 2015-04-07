// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web;

namespace AspDotNetStorefrontCore
{
	/// <summary>
	/// Summary description for Cardinal.
	/// </summary>
	public class Cardinal
	{
		public Cardinal() {}

		static public bool EnabledForCheckout(decimal cartTotal, string cardType)
		{
			var CardinalAllowed = AppLogic.AppConfigBool("CardinalCommerce.Centinel.Enabled") && 
				!(cartTotal == System.Decimal.Zero && 
				AppLogic.AppConfigBool("SkipPaymentEntryOnZeroDollarCheckout"));

			return CardinalAllowed && (cardType.Trim().Equals("VISA", StringComparison.InvariantCultureIgnoreCase) ||
				cardType.Trim().Equals("MASTERCARD", StringComparison.InvariantCultureIgnoreCase) ||
				cardType.Trim().Equals("JCB", StringComparison.InvariantCultureIgnoreCase));
		}

		static public bool PreChargeLookupAndStoreSession(Customer customer, int orderNumber, decimal cartTotal, string cardNumber, string expMonth, string expYear)
		{
			// use cardinal pre-auth fraud screening:
			String ACSUrl = String.Empty;
			String Payload = String.Empty;
			String TransactionID = String.Empty;
			String CardinalLookupResult = String.Empty;

			if (Cardinal.PreChargeLookup(cardNumber, Localization.ParseUSInt(expYear), Localization.ParseUSInt(expMonth), orderNumber, cartTotal, "",
				out ACSUrl, out Payload, out TransactionID, out CardinalLookupResult))
			{
				// redirect to intermediary page which gets card password from user:
				customer.ThisCustomerSession["Cardinal.LookupResult"] = CardinalLookupResult;
				customer.ThisCustomerSession["Cardinal.ACSUrl"] = ACSUrl;
				customer.ThisCustomerSession["Cardinal.Payload"] = Payload;
				customer.ThisCustomerSession["Cardinal.TransactionID"] = TransactionID;
				customer.ThisCustomerSession["Cardinal.OrderNumber"] = orderNumber.ToString();

				return true;
			}
			else
			{
				customer.ThisCustomerSession["Cardinal.LookupResult"] = CardinalLookupResult;
			}

			return false;
		}

		static public string GetECIFlag(string cardType)
		{
			// set the ECIFlag for an 'N' Enrollment response, so the merchant receives Liability Shift Protection
			string ECIFlag;
			if (cardType.Trim().Equals("VISA", StringComparison.InvariantCultureIgnoreCase))
			{
				ECIFlag = "06";  // Visa Card Issuer Liability
			}
			else if (cardType.Trim().Equals("JCB", StringComparison.InvariantCultureIgnoreCase))
			{
				ECIFlag = "07";  // Indicates Merchant Liability 
			}
			else
			{
				ECIFlag = "01";  // MasterCard Merchant Liability for non-enrolled card (rules differ between MC and Visa in the regard)
			}

			return ECIFlag;
		}

		// returns true if no errors, and card is enrolled:
		static public bool PreChargeLookup(String CardNumber, int CardExpirationYear, int CardExpirationMonth, int OrderNumber, decimal OrderTotal, String OrderDescription, out String ACSUrl, out String Payload, out String TransactionID, out String CardinalLookupResult)
		{
			CardinalCommerce.CentinelRequest ccRequest = new CardinalCommerce.CentinelRequest();
			CardinalCommerce.CentinelResponse ccResponse = new CardinalCommerce.CentinelResponse();

			// ==================================================================================
			// Construct the cmpi_lookup message
			// ==================================================================================

			ccRequest.add("MsgType", AppLogic.AppConfig("CardinalCommerce.Centinel.MsgType.Lookup"));
            ccRequest.add("Version", "1.7");
            ccRequest.add("ProcessorId", AppLogic.AppConfig("CardinalCommerce.Centinel.ProcessorID"));
			ccRequest.add("MerchantId", AppLogic.AppConfig("CardinalCommerce.Centinel.MerchantID"));
            ccRequest.add("TransactionPwd", AppLogic.AppConfig("CardinalCommerce.Centinel.TransactionPwd"));
            ccRequest.add("TransactionType", "C"); //C = Credit Card / Debit Card Authentication.
            ccRequest.add("Amount", Localization.CurrencyStringForGatewayWithoutExchangeRate(OrderTotal).Replace(",", "").Replace(".", ""));
            ccRequest.add("CurrencyCode", Localization.StoreCurrencyNumericCode());
            ccRequest.add("CardNumber", CardNumber);
            ccRequest.add("CardExpMonth", CardExpirationMonth.ToString().PadLeft(2, '0'));
            ccRequest.add("CardExpYear", CardExpirationYear.ToString().PadLeft(4, '0'));
            ccRequest.add("OrderNumber", OrderNumber.ToString());

            // Optional fields
            ccRequest.add("OrderDescription", OrderDescription);
            ccRequest.add("UserAgent", CommonLogic.ServerVariables("HTTP_USER_AGENT"));
            ccRequest.add("Recurring", "N");
			
			int NumAttempts = AppLogic.AppConfigUSInt("CardinalCommerce.Centinel.NumRetries");
			if(NumAttempts == 0)
			{
				NumAttempts = 1;
			}
			bool CallWasOK = false;
			for(int i = 1; i <= NumAttempts; i++)
			{
				CallWasOK = true;
				try
				{
					String URL = AppLogic.AppConfig("CardinalCommerce.Centinel.TransactionUrl.Test");
					if(AppLogic.AppConfigBool("CardinalCommerce.Centinel.IsLive"))
					{
						URL = AppLogic.AppConfig("CardinalCommerce.Centinel.TransactionUrl.Live");
					}
					ccResponse = ccRequest.sendHTTP(URL, AppLogic.AppConfigUSInt("CardinalCommerce.Centinel.MapsTimeout"));
				}
				catch
				{
					CallWasOK = false;
				}
				if(CallWasOK)
				{
					break;
				}
			}

			Payload = String.Empty;
			ACSUrl = String.Empty;
			TransactionID = String.Empty;
			if(CallWasOK)
			{
				String errorNo = ccResponse.getValue("ErrorNo");
				String enrolled = ccResponse.getValue("Enrolled");
				Payload = ccResponse.getValue("Payload");
				ACSUrl = ccResponse.getValue("ACSUrl");
				TransactionID = ccResponse.getValue("TransactionId");

				CardinalLookupResult = ccResponse.getUnparsedResponse();

				ccRequest = null;
				ccResponse = null;

				//======================================================================================
				// Assert that there was no error code returned and the Cardholder is enrolled in the
				// Payment Authentication Program prior to starting the Authentication process.
				//======================================================================================

				if(errorNo == "0" && enrolled == "Y")
				{
					return true;
				}
				return false;
			}
			ccRequest = null;
			ccResponse = null;
			CardinalLookupResult = AppLogic.GetString("cardinal.cs.1",1,Localization.GetDefaultLocale());
			return false;
		}

		static public String PreChargeAuthenticate(int OrderNumber, String PaRes, String TransactionID, out String PAResStatus, out String SignatureVerification, out String ErrorNo, out String ErrorDesc, out String CardinalAuthenticateResult)
		{
			CardinalCommerce.CentinelRequest ccRequest = new CardinalCommerce.CentinelRequest();
			CardinalCommerce.CentinelResponse ccResponse = new CardinalCommerce.CentinelResponse();

			ErrorNo = String.Empty;
			ErrorDesc = String.Empty;
			PAResStatus = String.Empty;
			SignatureVerification = String.Empty;


			if(PaRes.Length == 0 || TransactionID.Length == 0)
			{
				CardinalAuthenticateResult = AppLogic.GetString("cardinal.cs.3",1,Localization.GetDefaultLocale());
				return AppLogic.GetString("cardinal.cs.2",1,Localization.GetDefaultLocale());
			}
			else
			{

				// ==================================================================================
				// Construct the cmpi_authenticate message
				// ==================================================================================

				ccRequest.add("MsgType", AppLogic.AppConfig("CardinalCommerce.Centinel.MsgType.Authenticate")); //cmpi_authenticate
                ccRequest.add("Version", "1.7");
                ccRequest.add("ProcessorId", AppLogic.AppConfig("CardinalCommerce.Centinel.ProcessorID")); 
				ccRequest.add("MerchantId", AppLogic.AppConfig("CardinalCommerce.Centinel.MerchantID"));
                ccRequest.add("TransactionType", "C");
                ccRequest.add("TransactionPwd", AppLogic.AppConfig("CardinalCommerce.Centinel.TransactionPwd"));
				ccRequest.add("TransactionId", TransactionID);
				ccRequest.add("PAResPayload", HttpContext.Current.Server.HtmlEncode(PaRes));

				int NumAttempts = AppLogic.AppConfigUSInt("CardinalCommerce.Centinel.NumRetries");
				if(NumAttempts == 0)
				{
					NumAttempts = 1;
				}
				bool CallWasOK = false;
				for(int i = 1; i <= NumAttempts; i++)
				{
					CallWasOK = true;
					try
					{
						String URL = AppLogic.AppConfig("CardinalCommerce.Centinel.TransactionUrl.Test");
						if(AppLogic.AppConfigBool("CardinalCommerce.Centinel.IsLive"))
						{
							URL = AppLogic.AppConfig("CardinalCommerce.Centinel.TransactionUrl.Live");
						}
						ccResponse = ccRequest.sendHTTP(URL, AppLogic.AppConfigUSInt("CardinalCommerce.Centinel.MapsTimeout"));
					}
					catch
					{
						CallWasOK = false;
					}
					if(CallWasOK)
					{
						break;
					}
				}

				if(CallWasOK)
				{
					CardinalAuthenticateResult = ccResponse.getUnparsedResponse();
					String tmpS = ccResponse.getUnparsedResponse();
					ccRequest = null;
					ccResponse = null;
					return tmpS;
				}
				ccRequest = null;
				ccResponse = null;
				CardinalAuthenticateResult = AppLogic.GetString("cardinal.cs.4",1,Localization.GetDefaultLocale());
				return AppLogic.GetString("cardinal.cs.5",1,Localization.GetDefaultLocale());
			}
		}
	}
}
