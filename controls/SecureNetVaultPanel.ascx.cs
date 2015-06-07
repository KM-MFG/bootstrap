// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontGateways;

namespace AspDotNetStorefront
{
	public partial class SecureNetVaultPanel : UserControl
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if(AppLogic.ActivePaymentGatewayCleaned() != Gateway.ro_GWSECURENETVAULTV4 || !AppLogic.SecureNetVaultIsEnabled())
			{
				Visible = false;
				return;
			}

			litSNCError.Text = "";

			if(!Page.IsPostBack)
				LoadData();
		}

		protected void btnSecureNetSaveCard_Click(object sender, EventArgs e)
		{
			Page.Validate("SecureNetAddCard");
			if(!Page.IsValid)
				return;

			var customer = (Page as SkinBase).ThisCustomer;
			var secureNetVault = new SecureNetVault(customer);

			ServiceResponse serviceResponse;
			try
			{
				serviceResponse = secureNetVault.AddCreditCardToCustomerVault(
					SecureNetCreditCardPanel.CreditCardName,
					SecureNetCreditCardPanel.CreditCardNumber,
					SecureNetCreditCardPanel.CreditCardVerCd,
					SecureNetCreditCardPanel.CreditCardType,
					SecureNetCreditCardPanel.CardExpMonth,
					SecureNetCreditCardPanel.CardExpYr);
			}
			catch
			{
				litSNCError.Text = "There was an error adding your credit card. Please validate the provided information and try again.";
				return;
			}

			if(serviceResponse.HasError)
			{
				litSNCError.Text = serviceResponse.Message;
				return;
			}

			LoadData();
			pnlAddSecureNetCard.Visible = false;
			AddNewCardButton.Visible = true;
			SecureNetCreditCardPanel.Clear();
		}

		protected void CardRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
		{
			if(e.CommandName == "Delete")
			{
				var customer = (Page as SkinBase).ThisCustomer;
				var secureNetVault = new SecureNetVault(customer);
				try
				{
					secureNetVault.DeletePaymentMethod((string)e.CommandArgument);
				}
				catch
				{
					litSNCError.Text = "There was an error deleting your credit card. Please try again.";
					return;
				}

				LoadData();
			}
		}

		protected void AddNewVaultCard(object sender, EventArgs e)
		{
			pnlAddSecureNetCard.Visible = true;
			AddNewCardButton.Visible = false;
		}

		void LoadData()
		{
			var customer = (Page as SkinBase).ThisCustomer;
			var customerValue = SecureNetDataReport.GetCustomerVault(customer.CustomerID);
			var paymentMethods = customerValue != null
				? SecureNetDataReport.GetCustomerVault(customer.CustomerID).SavedPayments
				: new List<CustomerVaultPayment>();

			CardRepeater.DataSource = paymentMethods;
			CardRepeater.DataBind();
		}
	}
}
