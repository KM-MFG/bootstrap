// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontAdmin;
using AspDotNetStorefrontControls;

public partial class Admin_AvalaraConnectionTest : AdminPageBase
{
	protected void Page_Load(object sender, EventArgs e)
	{
		try
		{
			bool success = false;
			string reason = String.Empty;

			if (!AppLogic.AppConfigBool("AvalaraTax.Enabled"))
				ctlAlertMessage.PushAlertMessage("AvaTax is not enabled. Enable AvaTax by setting the AvalaraTax.Enabled AppConfig to True.", AlertMessage.AlertType.Warning);
			else
			{
				AvaTax avaTax = new AvaTax();
				success = avaTax.TestAddin(out reason);

				if (success)
					ctlAlertMessage.PushAlertMessage("Successfully connected to AvaTax.", AlertMessage.AlertType.Success);
				else if (String.IsNullOrEmpty(reason))
					ctlAlertMessage.PushAlertMessage("AvaTax connection was not successful. Please review your configuration.", AlertMessage.AlertType.Error);
				else
					ctlAlertMessage.PushAlertMessage(String.Format("AvaTax connection was not successful. AvaTax returned the following message: {0}", reason), AlertMessage.AlertType.Error);
			}
		}
		catch (Exception exception)
		{
			ctlAlertMessage.PushAlertMessage("Connection test failed due to an exception:<br />" + exception.ToString().Replace("\n", "<br />"), AlertMessage.AlertType.Error);
		}
	}
}
