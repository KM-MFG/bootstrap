// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using GatewayAuthorizeNet;

public partial class CIM_Wallet : System.Web.UI.UserControl
{
	protected void Page_Load(object sender, EventArgs e)
	{
		CreditCardEditor.CardEditComplete += CreditCardEditor_CardEditComplete;

		if(!Page.IsPostBack)
			BindPage();
	}

	void BindPage()
	{
		PanelAddPaymentType.Visible = false;
		ButtonAddPaymentType.Visible = true;

		AspDotNetStorefrontCore.Customer adnsfCustomer = AspDotNetStorefrontCore.Customer.Current;

		CardRepeater.DataSource = DataUtility.GetPaymentProfiles(adnsfCustomer.CustomerID, adnsfCustomer.EMail);
		CardRepeater.DataBind();
	}

	protected void CardRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
	{
		if(e.CommandName == "Delete")
		{
			var customer = AspDotNetStorefrontCore.Customer.Current;

			var profileId = DataUtility.GetProfileId(customer.CustomerID);
			var paymentProfileId = Int64.Parse((string)e.CommandArgument);

			var profileMgr = new ProfileManager(customer.CustomerID, customer.EMail, profileId);
			profileMgr.DeletePaymentProfile(paymentProfileId);
			DataUtility.DeletePaymentProfile(customer.CustomerID, paymentProfileId);

			BindPage();
		}
		else if(e.CommandName == "Edit")
		{
			PanelAddPaymentType.Visible = true;
			ButtonAddPaymentType.Visible = false;
			CreditCardEditor.BindPage(Int64.Parse((string)e.CommandArgument));
		}
	}

	protected void CreditCardEditor_CardEditComplete(object sender, EventArgs e)
	{
		BindPage();
	}

	protected void ButtonAddPaymentType_Click(object sender, EventArgs e)
	{
		PanelAddPaymentType.Visible = true;
		ButtonAddPaymentType.Visible = false;
		CreditCardEditor.BindPage(0);
	}
}
