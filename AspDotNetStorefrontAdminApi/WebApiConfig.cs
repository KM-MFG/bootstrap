// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web.Http;
using AspDotNetStorefrontAdminApi.Filters;

namespace AspDotNetStorefrontAdminApi
{
	public static class WebApiConfig
	{
		public static void Register(HttpConfiguration config)
		{
			config.MapHttpAttributeRoutes();
			config.Filters.Add(new SecureConnectionFilter());
			config.Filters.Add(new AuthorizedCustomerHeaderFilter());
		}
	}
}
