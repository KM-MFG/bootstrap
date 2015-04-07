// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;
using AspDotNetStorefrontCore;
using Newtonsoft.Json.Linq;

namespace AspDotNetStorefrontAdminApi.Filters
{
	public class SecureConnectionFilter : AuthorizationFilterAttribute
	{
		public override void OnAuthorization(HttpActionContext actionContext)
		{
			if (!AppLogic.UseSSL())
				return;

			var request = actionContext.Request;
			if(((System.Web.HttpContextWrapper)request.Properties["MS_HttpContext"]).Request.IsSecureConnection)
				return;

			HttpResponseMessage response;
			var uri = new UriBuilder(request.RequestUri)
				{
					Scheme = Uri.UriSchemeHttps,
					Port = 443
				};

			var error = JObject.FromObject(new
				{
					error = new 
						{
							message = string.Format("The resource can be found at <a href='{0}'>{0}</a>.", uri.Uri.AbsoluteUri)
						}
				});

			if(request.Method.Equals(HttpMethod.Get) || request.Method.Equals(HttpMethod.Head))
			{
				response = request.CreateResponse(HttpStatusCode.Found);
				response.Headers.Location = uri.Uri;
				if(request.Method.Equals(HttpMethod.Get))
				{
					response.Content = new StringContent(error.ToString(), Encoding.UTF8, "application/json");
				}
			}
			else
			{
				response = request.CreateResponse(HttpStatusCode.NotFound);
				response.Content = new StringContent(error.ToString(), Encoding.UTF8, "application/json");
			}

			actionContext.Response = response;
		}
	}
}
