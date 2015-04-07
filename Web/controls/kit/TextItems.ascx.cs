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
	public partial class TextItems : BaseKitGroupControl
	{
		protected TextBoxMode DetermineTextMode()
		{
			if(KitGroup.SelectionControl == KitGroupData.TEXT_AREA)
			{
				return TextBoxMode.MultiLine;
			}
			else
			{
				return TextBoxMode.SingleLine;
			}
		}

		protected int DetermineTextColumns()
		{
			if(KitGroup.SelectionControl == KitGroupData.TEXT_AREA)
			{
				return 50;
			}
			else
			{
				return 70;
			}
		}

		protected void rptItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				KitItemData kitItem = e.Item.DataItemAs<KitItemData>();
				Label lblItem = e.Item.FindControl<Label>("lblItemName");

				if(kitItem.HasMappedVariant && !kitItem.VariantHasStock && !AppLogic.AppConfigBool("KitInventory.AllowSaleOfOutOfStock"))
				{
					lblItem.Text += AppLogic.AppConfigBool("KitInventory.ShowOutOfStockMessage") ? string.Format("<span class=\"out-stock-hint\"> - {0}</span>", AppLogic.GetString("OutofStock.DisplayOutOfStockOnProductPage", ThisCustomer.LocaleSetting)) : String.Empty;
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
			TextBox txtKitItemText = item.FindControl<TextBox>("txtKitItemText");

			int kitItemId = hdfKitItemId.Value.ToNativeInt();
			KitItemData kitItem = KitGroup.GetItem(kitItemId);

			kitItem.IsSelected = !string.IsNullOrEmpty(txtKitItemText.Text);
			kitItem.TextOption = txtKitItemText.Text;
		}
	}
}
