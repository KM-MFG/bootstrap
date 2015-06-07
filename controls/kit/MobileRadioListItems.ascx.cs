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
	public partial class MobileRadioListItems : BaseKitGroupControl
	{
		protected void rptItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if(e.Item.ItemType == ListItemType.Item ||
				e.Item.ItemType == ListItemType.AlternatingItem)
			{
				RadioButton rbItem = e.Item.FindControl<RadioButton>("rbItem");
				KitItemData kitItem = e.Item.DataItemAs<KitItemData>();
				Label lblItem = e.Item.FindControl<Label>("lblItemName");

				rbItem.Attributes["onclick"] = string.Format("SetUniqueRadioButton('{0}', '{1}',this)", rptItems.UniqueID, rbItem.GroupName);
				if(kitItem.HasMappedVariant && !kitItem.VariantHasStock && !AppLogic.AppConfigBool("KitInventory.AllowSaleOfOutOfStock"))
				{
					lblItem.Text += AppLogic.AppConfigBool("KitInventory.ShowOutOfStockMessage") ? string.Format("<span class=\"errorLg\"> - {0}</span>", AppLogic.GetString("OutofStock.DisplayOutOfStockOnProductPage", ThisCustomer.LocaleSetting)) : String.Empty;
					rbItem.Checked = false;
					rbItem.Enabled = false;
					kitItem.IsSelected = false;
				}
				else
				{
					bool isSetTrue = false;
					foreach(var kitItem1 in KitGroup.SelectableItems)
					{
						if(kitItem1.IsSelected == true)
						{
							isSetTrue = true;
						}
					}
					if(isSetTrue == false)
					{
						kitItem.IsSelected = true;
					}
				}
				rbItem.Checked = kitItem.IsSelected;
			}
		}

		public override void ResolveSelection()
		{
			rptItems.ForEachItemTemplate(RepeaterItemIterator);
		}

		private void RepeaterItemIterator(RepeaterItem item)
		{
			HiddenField hdfKitItemId = item.FindControl<HiddenField>("hdfKitItemId");
			RadioButton rbItem = item.FindControl<RadioButton>("rbItem");

			int kitItemId = hdfKitItemId.Value.ToNativeInt();
			KitItemData kitItem = KitGroup.GetItem(kitItemId);

			kitItem.IsSelected = rbItem.Checked;
		}
	}
}
