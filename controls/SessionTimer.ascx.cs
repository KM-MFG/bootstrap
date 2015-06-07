// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web;
using System.Web.UI;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefront
{
	public partial class controls_SessionTimer : System.Web.UI.UserControl
	{
        protected void Page_Load(object sender, EventArgs e)
		{
			var customer = ((AspDotNetStorefrontPrincipal)HttpContext.Current.User).ThisCustomer;
			var sessionTimeoutInSeconds = (customer.IsAdminUser || customer.IsAdminSuperUser)
				? AppLogic.AdminSessionTimeout()
				: AppLogic.SessionTimeout();

			var sessionTimeoutInMilliSeconds = sessionTimeoutInSeconds * 60000;

			AddSessionTimerToPage(sessionTimeoutInMilliSeconds);
        }

		private void AddSessionTimerToPage(int sessionTimeoutInMilliSeconds)
		{
			var script = String.Format(@"
				var sessionTimeoutInMilliSeconds = {0};", sessionTimeoutInMilliSeconds);

			Page.ClientScript.RegisterStartupScript(this.GetType(), "sessiontimervars", script.ToString(), true);
		}
	}
}
