// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefrontAdmin
{
	public partial class _InventoryControl : AdminPageBase
	{
		string SelectedLocale;

		protected void Page_Load(object sender, EventArgs e)
		{
			Page.Form.DefaultButton = btnUpdate.UniqueID;
			
			SelectedLocale = LocaleSelector
				.GetSelectedLocale()
				.Name;

			if(!Page.IsPostBack)
				LoadPageContent(SelectedLocale);
		}

		protected void Page_PreRender(object sender, EventArgs e)
		{
			DataBind();
		}

		protected void btnUpdate_Click(object sender, EventArgs e)
		{
			UpdateStringResources(SelectedLocale);
			UpdateAppConfigs();
			LoadPageContent(SelectedLocale);
			ctrlAlertMessage.PushAlertMessage(AppLogic.GetString("admin.common.updated", ThisCustomer.LocaleSetting), AlertMessage.AlertType.Success);
		}

		protected void LocaleSelector_SelectedLocaleChanged(object sender, EventArgs e)
		{
			LoadPageContent(SelectedLocale);
		}

		void LoadPageContent(string locale)
		{
			LoadAppConfigs();
			LoadStringResources(locale);
		}

		void LoadAppConfigs()
		{
			txtHideProductsWithLessThanThisInventoryLevel.Text = AppLogic.AppConfig("HideProductsWithLessThanThisInventoryLevel", 0, false);
			txtOutOfStockThreshold.Text = AppLogic.AppConfig("OutOfStockThreshold", 0, false);

			chkDisplayOutOfStockMessage.Checked = AppLogic.AppConfigBool("DisplayOutOfStockProducts", 0, true);
			chkLimitCartToQuantityOnHand.Checked = AppLogic.AppConfigBool("Inventory.LimitCartToQuantityOnHand", 0, true);
			chkShowOutOfStockMessageOnProductPages.Checked = AppLogic.AppConfigBool("DisplayOutOfStockOnProductPages", 0, true);
			chkShowOutOfStockMessageOnEntityPages.Checked = AppLogic.AppConfigBool("DisplayOutOfStockOnEntityPages", 0, true);

			rdbShowOutOfStockMessage.SelectedIndex = AppLogic.AppConfigBool("KitInventory.ShowOutOfStockMessage", 0, true) == true ? 0 : 1;
			rblAllowSaleOfOutOfStock.SelectedIndex = AppLogic.AppConfigBool("KitInventory.AllowSaleOfOutOfStock", 0, true) == true ? 0 : 1;

			chkProductPageOutOfStockRedirect.Checked = AppLogic.AppConfigBool("ProductPageOutOfStockRedirect", 0, true);
		}

		void UpdateAppConfigs()
		{
			AppConfigManager.SetAppConfigDBAndCache(0, "Inventory.LimitCartToQuantityOnHand", chkLimitCartToQuantityOnHand.Checked.ToString());

			AppConfigManager.SetAppConfigDBAndCache(0, "HideProductsWithLessThanThisInventoryLevel", txtHideProductsWithLessThanThisInventoryLevel.Text);

			AppConfigManager.SetAppConfigDBAndCache(0, "DisplayOutOfStockProducts", chkDisplayOutOfStockMessage.Checked.ToString());
			AppConfigManager.SetAppConfigDBAndCache(0, "OutOfStockThreshold", txtOutOfStockThreshold.Text);
			AppConfigManager.SetAppConfigDBAndCache(0, "DisplayOutOfStockOnProductPages", chkShowOutOfStockMessageOnProductPages.Checked.ToString());
			AppConfigManager.SetAppConfigDBAndCache(0, "DisplayOutOfStockOnEntityPages", chkShowOutOfStockMessageOnEntityPages.Checked.ToString());

			AppConfigManager.SetAppConfigDBAndCache(0, "KitInventory.ShowOutOfStockMessage", rdbShowOutOfStockMessage.SelectedValue.ToString());
			AppConfigManager.SetAppConfigDBAndCache(0, "KitInventory.AllowSaleOfOutOfStock", rblAllowSaleOfOutOfStock.SelectedValue.ToString());

			AppConfigManager.SetAppConfigDBAndCache(0, "ProductPageOutOfStockRedirect", chkProductPageOutOfStockRedirect.Checked.ToString().ToLower());
		}

		void LoadStringResources(string locale)
		{
			txtProductOutOfStockMessage.Text = AppLogic.GetString("OutOfStock.DisplayOutOfStockOnProductPage", SkinID, locale);
			txtEntityOutOfStockMessage.Text = AppLogic.GetString("OutOfStock.DisplayOutOfStockOnEntityPage", SkinID, locale);
			txtProductInStockMessage.Text = AppLogic.GetString("OutOfStock.DisplayInStockOnProductPage", SkinID, locale);
			txtEntityInStockMessage.Text = AppLogic.GetString("OutOfStock.DisplayInStockOnEntityPage", SkinID, locale);
			txtKitItemOutOfStockSellAnyway.Text = AppLogic.GetString("OutofStock.DisplaySellableOutOfStockOnKitPage", SkinID, locale);
		}

		void UpdateStringResources(string locale)
		{
			UpdateStringResource("OutofStock.DisplayOutOfStockOnProductPage", txtProductOutOfStockMessage.Text, locale);
			UpdateStringResource("OutofStock.DisplayOutOfStockOnEntityPage", txtEntityOutOfStockMessage.Text, locale);
			UpdateStringResource("OutofStock.DisplayInStockOnProductPage", txtProductInStockMessage.Text, locale);
			UpdateStringResource("OutofStock.DisplayInStockOnEntityPage", txtEntityInStockMessage.Text, locale);
			UpdateStringResource("OutofStock.DisplaySellableOutOfStockOnKitPage", txtKitItemOutOfStockSellAnyway.Text, locale);
		}

		private void UpdateStringResource(string name, string value, string locale)
		{
			var stringResource = StringResourceManager.GetStringResource(AppLogic.StoreID(), locale, name);
			if(stringResource == null)
			{
				StringResource.Create(AppLogic.StoreID(), name, locale, value.Trim());
				
				// Reload string resources from DB. Necessary after creating a new string resource.
				StringResourceManager.LoadAllStrings(false);
			}
			else
				stringResource.Update(name, locale, value.Trim());
		}
	}
}
