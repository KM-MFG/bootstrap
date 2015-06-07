// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web.UI.WebControls;

namespace AspDotNetStorefrontAdmin
{
	public partial class GlobalConfigs : AdminPageBase
	{
		protected void Page_Load(Object sender, EventArgs e)
		{
			Response.CacheControl = "private";
			Response.Expires = 0;
			Response.AddHeader("pragma", "no-cache");
		}
	}
}
