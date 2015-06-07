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
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
    public partial class NewAdmin_App_Templates_AdminMaster : AdminMasterPageBase
    {
        #region eventHandlers

        /// <summary>
        /// Default page load event
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            bool IsBeingImpersonated = false;
            try
            {
                IsBeingImpersonated = ((String)HttpContext.Current.Items["IsBeingImpersonated"] == "true");
            }
            catch { }
            ImpersonationWarning.Visible = IsBeingImpersonated;

			String menuPath = AppLogic.AdminLinkUrl("Controls/VerticalMenu.ascx", true);
			Menu.Controls.Add(LoadControl(menuPath));

			String configurationMenuPath = AppLogic.AdminLinkUrl("Controls/ConfigurationMenu.ascx", true);
			ConfigurationMenu.Controls.Add(LoadControl(configurationMenuPath));

			String manualSearchPath = AppLogic.AdminLinkUrl("Controls/ManualSearch.ascx", true);
			ManualSearch.Controls.Add(LoadControl(manualSearchPath));

			String storeNavigatorPath = AppLogic.AdminLinkUrl("Controls/StoreNavigator.ascx", true);
			StoreNavigator.Controls.Add(LoadControl(storeNavigatorPath));
        }

        protected void btnStopImpersonation_Click(object sender, EventArgs e)
        {
            ThisCustomer.ThisCustomerSession["IGD"] = "";
            ThisCustomer.ThisCustomerSession["IGDEDITINGORDER"] = "";
			ImpersonationWarning.Visible = false;
        }

        /// <summary>
        /// Handles search functionality within the admin page header
        /// </summary>
        protected void search_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("search.aspx?searchterm=" + txtSearch.Text);
        }
        #endregion
    }
}
