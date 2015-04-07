// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Linq;
using AspDotNetStorefrontCore;

public partial class Admin_Controls_StoreNavigator : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
		BindStores();
    }

	private void BindStores()
	{
		var urlType = Store.DetermineCurrentUrlType();
		storeList.DataSource = Store
			.GetStoreList()
			.Select(s => new
				{
					Name = s.Name,
					//If the current store is the store we're on, use applogic.resolve url because it will handle directories. 
					//Otherwise use the raw url from the store table which cannot contain directories
					//If the store url set in stores.aspx is bad, don't create a link
					Url = s.StoreID == AppLogic.StoreID()
						? AppLogic.ResolveUrl("~/")
						: String.Format("http://{0}", Store.GetStoreUrlByType(urlType, s.StoreID))
				})
			.Where(s => Uri.IsWellFormedUriString(s.Url, UriKind.RelativeOrAbsolute));			

		storeList.DataBind();
	}
}
