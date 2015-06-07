// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using AspDotNetStorefrontCore;
using System.Xml;
using System.Xml.Xsl;
using System.IO;
using AspDotNetStorefrontControls;

namespace AspDotNetStorefront
{
    /// <summary>
    /// Summary description for sitemap.
    /// </summary>
    public partial class sitemap : SkinBase
    {

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (AppLogic.AppConfigBool("GoNonSecureAgain"))
            {
                GoNonSecureAgain();
            }
            SectionTitle = AppLogic.GetString("sitemap.aspx.1", SkinID, ThisCustomer.LocaleSetting);
            String XmlPackageName = AppLogic.AppConfig("XmlPackage.SiteMapPage");            
            if (XmlPackageName.Length != 0)
            {
				SiteMapXmlPackage.PackageName = XmlPackageName;
            }

        }

    }
}
