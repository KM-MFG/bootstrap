// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web.Http;
using AspDotNetStorefrontAdminApi.Filters;
using AspDotNetStorefrontCore;
using Newtonsoft.Json.Linq;

namespace AspDotNetStorefrontAdminApi
{
	[RoutePrefix("api/1/appconfig"), Authorize(Roles = "SuperAdmin,Admin"), SecureConnectionFilter]
	public class AppConfigController : ApiController
	{
		[Route("{name}", Name = "appconfig-get-byname")]
		public IHttpActionResult GetByName(string name, [FromUri] int storeId = 0)
		{
			var appConfig = AppLogic.GetAppConfig(storeId, name);
			
			if (appConfig == null) // If the appconfig is null, try looking it up for the default store.
				appConfig = AppLogic.GetAppConfig(0, name);

			if(appConfig == null)
				return NotFound();

			if(appConfig.SuperOnly && !RequestContext.Principal.IsInRole("SuperAdmin"))
				throw new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);

			return Ok(new
			{
				appConfig = new
				{
					name = name,
					value = appConfig.ConfigValue,
					storeId = appConfig.StoreId
				}
			});
		}

		[Route(Name = "appconfig-post")]
		public IHttpActionResult Post([FromBody] JObject appConfig)
		{
			if (appConfig == null)
				return BadRequest("App config must be specified.");

			var name = (string)appConfig["name"];
			var value = (string)appConfig["value"];
			var description = (string)appConfig["description"];
			var groupName = (string)appConfig["groupName"];
			var storeId = (int)appConfig["storeId"];

			if(string.IsNullOrEmpty(name))
				return BadRequest("Name of app config must be specified.");

			if(value == null)
				return BadRequest("Value of app config must be specified.");

			if (AppConfigManager.AppConfigExists(storeId, name))
				return Conflict();

			var result = AppConfigManager.CreateDBAndCacheAppConfig(
				Name: name,
				Description: description,
				ConfigValue: value,
				valueType: "string",
				allowableValues: string.Empty,
				GroupName: groupName,
				SuperOnly: false,
				storeId: storeId);

			// The appconfig manager does not create a default appconfig and so one has to be manually created if it doesn't exist.
			//  This is a current limitation of the app config editor in admin
			if(storeId != 0 && !AppConfigManager.AppConfigExists(0, name))
				AppConfigManager.CreateDBAndCacheAppConfig(
					Name: name,
					Description: description,
					ConfigValue: value,
					valueType: "string",
					allowableValues: string.Empty,
					GroupName: groupName,
					SuperOnly: false,
					storeId: 0);

			var route = Url.Link("appconfig-get-byname", new { name = name });
			return Created(route, new
			{
				name = result.Name,
				value = result.ConfigValue
			});
		}
	}
}
