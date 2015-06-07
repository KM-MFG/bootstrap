// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web.Http;

public class _Global : AspDotNetStorefront.Global
{
	public _Global()
	{
		InitializeApplicationCompleted += InitializeApplication_Completed;
	}

	void InitializeApplication_Completed(object sender, EventArgs e)
	{
		GlobalConfiguration.Configure(AspDotNetStorefrontAdminApi.WebApiConfig.Register);
		GlobalConfiguration.Configuration.EnsureInitialized();
	}
}
