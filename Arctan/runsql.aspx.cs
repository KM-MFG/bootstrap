// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
    /// <summary>
    /// Summary description for runsql.
    /// </summary>
    public partial class runsql : AdminPageBase
    {
        private Customer cust;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            cust = ((AspDotNetStorefrontPrincipal)Context.User).ThisCustomer;

            Response.CacheControl = "private";
            Response.Expires = 0;
            Response.AddHeader("pragma", "no-cache");

            if (!cust.IsAdminSuperUser)
            {
				ctrlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.runsql.InsufficientPermission", cust.LocaleSetting), AlertMessage.AlertType.Warning);
                btnSubmit.Visible = false;
                txtQuery.Visible = false;
            }

            Page.Form.DefaultButton = btnSubmit.UniqueID;
            Page.Form.DefaultFocus = txtQuery.ClientID;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            String SQL = txtQuery.Text.Trim();
            try
            {
                if (SQL.Length != 0)
                {
                    DB.ExecuteLongTimeSQL(SQL, 1000);
					ctrlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.runsql.Ok", cust.LocaleSetting), AlertMessage.AlertType.Success);
                }
                else
                {
					ctrlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.runsql.NoInput", cust.LocaleSetting), AlertMessage.AlertType.Error);
                }
            }
            catch (Exception ex)
            {
				ctrlAlertMessage.PushAlertMessage(CommonLogic.GetExceptionDetail(ex, "<br/>"), AlertMessage.AlertType.Error);
            }
			//sets the trimmed sql back to the text box to make sure we don't have \n's or \r's
			txtQuery.Text = SQL;
        }
    }
}
