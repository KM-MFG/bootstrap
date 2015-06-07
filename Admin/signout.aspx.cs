// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web.Security;
using System.Web.UI;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
	public partial class signout : Page
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
			var customer = ((AspDotNetStorefrontPrincipal)Context.User).ThisCustomer;
			Security.LogEvent("Admin Logout", "", customer.CustomerID, customer.CustomerID, Convert.ToInt32(customer.CurrentSessionID));

			// Ensure CC and CCVV2 is cleared upon customer logout.
			Address BillingAddress = new Address();
			BillingAddress.LoadByCustomer(customer.CustomerID, customer.PrimaryBillingAddressID, AddressTypes.Billing);
			if(!customer.MasterShouldWeStoreCreditCardInfo)
				BillingAddress.ClearCCInfo();

			BillingAddress.UpdateDB();
			AppLogic.ClearCardExtraCodeInSession(customer);

			customer.ThisCustomerSession.Clear();

			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");

			customer.Logout();

			Session.Clear();
			Session.Abandon();
			FormsAuthentication.SignOut();

			Response.Write("<html>\n");
			Response.Write("<head>\n");
			Response.Write("<title>AspDotNetStorefront Admin - Signout</title>\n");
			Response.Write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n");
			Response.Write("<link rel=\"stylesheet\" href=\"" + AppLogic.AdminLinkUrl("~/App_Themes/Admin_Default/style.css") + "\" type=\"text/css\">\n");
			Response.Write("</head>\n");
			Response.Write("<body bgcolor=\"#FFFFFF\" topmargin=\"0\" marginheight=\"0\" bottommargin=\"0\" marginwidth=\"0\" rightmargin=\"0\">\n");
			Response.Write("<table width=\"100%\" height=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\n");
			Response.Write("<tr><td width=\"100%\" height=\"100%\" align=\"center\" valign=\"middle\">\n");
			Response.Write("Signout complete. Please wait.\n");
			Response.Write("</td></tr>\n");
			Response.Write("</table>\n");
			Response.Write("<script type=\"text/javascript\">\n");
			Response.Write("top.location='" + AppLogic.AdminLinkUrl("default.aspx") + "';\n");
			Response.Write("</script>\n");
			Response.Write("</body>\n");
			Response.Write("</html>\n");
		}
	}
}
