// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web.Http.Filters;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdminApi.Filters
{
	public class AuthorizedCustomerHeaderFilter : ActionFilterAttribute
	{
		public override void OnActionExecuted(HttpActionExecutedContext actionExecutedContext)
		{
			if(actionExecutedContext.Response == null)
				return;

			var customer = AppLogic.GetCurrentCustomer();
			if(customer == null)
				return;

			var customerIdentifier = customer.CustomerGUID.ToString();
			actionExecutedContext.Response.Headers.Add("X-AspDotNetStorefront-AuthorizedCustomerIdentifier", customerIdentifier);
		}
	}
}
