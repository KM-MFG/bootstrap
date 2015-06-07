// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Threading;
using System.Text;
using AspDotNetStorefrontCore;
using AspDotNetStorefrontControls;

namespace AspDotNetStorefront
{
    /// <summary>
    /// Summary description for MasterPageBase
    /// </summary>
    public class MasterPageBase : System.Web.UI.MasterPage
    {
        #region Variable Declaration

        protected ContentPlaceHolder PageContent;
        private string SEName = string.Empty;
        protected Literal SectionTitle;
        protected Menu aspnetMenu;
        protected ScriptManager scrptMgr;
        protected PlaceHolder ctrlMinicart;

        #endregion

        #region Constructor

        public MasterPageBase() 
        {
        }

        #endregion
        
        #region Properties

        protected Customer ThisCustomer
        {
            get { return Customer.Current; }
        }

        /// <summary>
        /// Gets or sets the SectionTitle text
        /// </summary>
        public string SectionTitleText
        {
            get
            {
                if (SectionTitle != null)
                {
                    return SectionTitle.Text;
                }

                return string.Empty;
            }
            set
            {
                if (SectionTitle != null)
                {
                    SectionTitle.Text = value;
                }
            }
        }

        /// <summary>
        /// Gets the content area panel
        /// </summary>
        public Panel ContentPanel
        {
            get
            {
                Panel pnl = this.PageContent.FindControl("pnlContent") as Panel;
                return pnl;
            }
        }

        /// <summary>
        /// Gets whether to use ajax addtocart functionality for the minicart
        /// </summary>
        public bool ShowMiniCart 
        {
            get 
            {
                return AppLogic.AppConfigBool("Minicart.UseAjaxAddToCart") && ShowMiniCartOnThisPage(); 
            }
        }


        /// <summary>
        /// Determines the visibility of the minicart based on the current requested page
        /// </summary>
        /// <returns></returns>
        private bool ShowMiniCartOnThisPage()
        {
            bool allowed = true;
            string pageName = CommonLogic.GetThisPageName(false);

            if (pageName.StartsWithIgnoreCase("shoppingcart") ||
                pageName.StartsWithIgnoreCase("checkout") ||
                pageName.StartsWithIgnoreCase("cardinal") ||
                pageName.StartsWithIgnoreCase("addtocart") ||
                pageName.ContainsIgnoreCase("_process") ||
                pageName.StartsWithIgnoreCase("lat_"))
            {
                allowed = false;
            }

            return allowed;
        }

        #endregion

        #region Methods

        protected override void OnInit(EventArgs e)
        {           
            if (this.RequireScriptManager)
            {               
                // provide hookup for individual pages
                (this.Page as SkinBase).RegisterScriptAndServices(scrptMgr);                
            }
            Page.ClientScript.RegisterClientScriptInclude(Page.GetType(), "formvalidate", ResolveClientUrl("~/jscripts/formvalidate.js"));
            Page.ClientScript.RegisterClientScriptInclude(Page.GetType(), "core", ResolveClientUrl("~/jscripts/core.js"));
            
            LoadMiniCartIfEnabled();

			// dynamically add the preview control to the page
			var pageContent = this.FindControl("PageContent") as ContentPlaceHolder;
			var profile = HttpContext.Current.Profile;
			if(pageContent != null 
                && profile != null
                && profile.PropertyValues["PreviewSkinID"] != null
                && CommonLogic.IsInteger(profile.GetPropertyValue("PreviewSkinID").ToString()))
			{
                Literal previewStyleLit = new Literal() { Text = "<link runat=\"server\" rel=\"stylesheet\" href=\"App_Templates/Admin_Default/previewstyles.css\" type=\"text/css\">" };
                this.Page.Header.Controls.Add(previewStyleLit);

                Control previewControl = LoadControl("~/Controls/EndPreview.ascx") as Control;
				pageContent.Controls.Add(previewControl);
			}

            base.OnInit(e);
        }

        public void LoadMiniCartIfEnabled()
        {
            if (this.ShowMiniCart && 
                ctrlMinicart != null)
            {
                Control ctrl = LoadControl("~/controls/minicart.ascx");
                ctrl.AppRelativeTemplateSourceDirectory = "~/";
                ctrlMinicart.Controls.Add(ctrl);
            }            
        }

        /// <summary>
        /// Gets whether to require asp.net ajax script manager
        /// </summary>
        public virtual bool RequireScriptManager
        {
            get 
            {
                return (this.Page as SkinBase).RequireScriptManager;
            }
        }
        
        /// <summary>
        /// Overrides the OnPreRender method
        /// </summary>
        /// <param name="e"></param>
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
        }
        #endregion
    }
}


