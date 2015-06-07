// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web.UI.WebControls;
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefront.Kit
{
	public partial class MultiSelectListItems : BaseKitGroupControl
	{
		protected void rptItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				KitItemData kitItem = e.Item.DataItemAs<KitItemData>();
				CheckBox chkItem = e.Item.FindControl("chkItem") as CheckBox;
				Label lblItem = e.Item.FindControl<Label>("lblItemName");

				if(kitItem.HasMappedVariant && !kitItem.VariantHasStock && !AppLogic.AppConfigBool("KitInventory.AllowSaleOfOutOfStock"))
				{
					lblItem.Text += AppLogic.AppConfigBool("KitInventory.ShowOutOfStockMessage") ? string.Format("<span class=\"out-stock-hint\"> - {0}</span>", AppLogic.GetString("OutofStock.DisplayOutOfStockOnProductPage", ThisCustomer.LocaleSetting)) : String.Empty;
				}

				if(chkItem != null && chkItem.Enabled == false && chkItem.Checked == true)
				{
					chkItem.Checked = false;
				}
			}
		}

		public override void ResolveSelection()
		{
			rptItems.ForEachItemTemplate(RepeaterItemIterator);
		}

		private void RepeaterItemIterator(RepeaterItem item)
		{
			HiddenField hdfKitItemId = item.FindControl<HiddenField>("hdfKitItemId");
			CheckBox chkItem = item.FindControl<CheckBox>("chkItem");

			int kitItemId = hdfKitItemId.Value.ToNativeInt();
			KitItemData kitItem = KitGroup.GetItem(kitItemId);

			kitItem.IsSelected = chkItem.Checked;
		}
	}
}
