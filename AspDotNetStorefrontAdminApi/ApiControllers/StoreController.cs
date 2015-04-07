// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Linq;
using System.Web.Http;
using AspDotNetStorefrontAdminApi.Filters;
using AspDotNetStorefrontCore;
using Newtonsoft.Json.Linq;

namespace AspDotNetStorefrontAdminApi
{
	[RoutePrefix("api/1/store"), Authorize(Roles = "SuperAdmin,Admin"), SecureConnectionFilter]
	public class StoreController : ApiController
	{
		[Route]
		public IHttpActionResult Get()
		{
			return Ok(new
			{
				stores = Store.GetStores(true)
				.Where(s => !s.Deleted)
				.Select(s => new
				{
					storeId = s.StoreID,
					storeGuid = s.StoreGuid,
					createdOn = s.CreatedOn,
					description = s.Description,
					developmentUri = s.DevelopmentURI,
					isDefault = s.IsDefault,
					name = s.Name,
					productionUri = s.ProductionURI,
					published = s.Published,
					skinId = s.SkinID,
					stagingUri = s.StagingURI,
				})
			});
		}

		[Route("{storeid}")]
		public IHttpActionResult Put(int storeId, [FromBody] JObject store)
		{
			if(store == null)
				return BadRequest("Store data must be specified.");

			var result = Store.GetStoreById(storeId);
			result.Description = (string)store["description"];
			result.DevelopmentURI = (string)store["developmentUri"];
			result.Name = (string)store["name"];
			result.ProductionURI = (string)store["productionUri"];
			result.Published = (bool)store["published"];
			result.SkinID = (int)store["skinId"];
			result.StagingURI = (string)store["stagingUri"];
			result.Save();

			return Ok(JObject.FromObject(new
			{
				store = new
				{
					storeId = result.StoreID,
					storeGuid = result.StoreGuid,
					createdOn = result.CreatedOn,
					description = result.Description,
					developmentUri = result.DevelopmentURI,
					name = result.Name,
					productionUri = result.ProductionURI,
					published = result.Published,
					skinId = result.SkinID,
					stagingUri = result.StagingURI,
				}
			}));
		}
	}
}
