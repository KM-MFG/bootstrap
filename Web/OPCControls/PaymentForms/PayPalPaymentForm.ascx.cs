// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Vortx.OnePageCheckout.UI;
using Vortx.OnePageCheckout.Views;
using Vortx.OnePageCheckout.Models;
using Vortx.OnePageCheckout.Models.PaymentMethods;

[PaymentType(Vortx.OnePageCheckout.Models.PaymentType.PayPal)]
public partial class OPCControls_PayPalPaymentForm :
    OPCUserControl<PaymentMethodBaseModel>,
    IPaymentMethodView
{
	#region IView Members

	public override void Initialize()
	{
	}

	public override void Disable()
	{
	}

	public override void Enable()
	{
	}

	public override void Show()
	{
		this.PanelPayPalDetails.Visible = true;
		this.Visible = true;
	}

	public override void Hide()
	{
		this.PanelPayPalDetails.Visible = false;
		this.Visible = false;
	}

	public override void BindView()
	{
	}

	public override void BindView(object identifier)
	{
	}

	public override void SaveViewToModel()
	{
		Response.Clear();
		Response.Write("<html><head><meta HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\"></head>");
        Response.Write("<body onload=\"document.PayPalForm.submit();\">");

        Response.Write(((PayPalPaymentModel)this.Model).PayPalPaymentForm);
		Response.Write("</body></html>");
        Response.End();
	}

	public override void ShowError(string message)
	{
	}

	#endregion

    public void FirePaymentFormSubmitted()
    {
        if (PaymentFormSubmitted != null)
            PaymentFormSubmitted(this, null);
    }

    public event EventHandler PaymentFormSubmitted;
}
