// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Linq;
using System.Web.UI.WebControls;
using AspDotNetStorefrontControls;
using AspDotNetStorefrontCore;

namespace AspDotNetStorefront.Kit
{
	public partial class DropDownListItems : BaseKitGroupControl
	{
		public override void DataBind()
		{
			base.DataBind();
			PopulateDropDown();
		}

		private void PopulateDropDown()
		{
			ddlKitItems.Items.Clear();
			foreach(var kitItem in KitGroup.SelectableItems)
			{
				ListItem thisListItem = new ListItem();

				// truncate after 75 chars to maintain a proper width for the dropdown
				thisListItem.Text = KitItemDisplayText(kitItem, 60);
				thisListItem.Value = kitItem.Id.ToString();

				if(kitItem.HasMappedVariant && !kitItem.VariantHasStock && !AppLogic.AppConfigBool("KitInventory.AllowSaleOfOutOfStock"))
				{
					thisListItem.Text += AppLogic.AppConfigBool("KitInventory.ShowOutOfStockMessage") ? string.Format(" - {0}", AppLogic.GetString("OutofStock.DisplayOutOfStockOnProductPage", ThisCustomer.LocaleSetting)) : String.Empty;
					thisListItem.Attributes.Add("disabled", "disabled");
					thisListItem.Selected = false;
					kitItem.IsSelected = false;
					litStockHint.Text = StockHint(KitGroup.SelectableItems.FirstOrDefault());
				}
				else
				{
					bool isSetTrue = false;
					foreach(var selectableKitItem in KitGroup.SelectableItems)
					{
						if(selectableKitItem.IsSelected == true)
						{
							isSetTrue = true;
						}
					}
					if(isSetTrue == false)
					{
						kitItem.IsSelected = true;
					}
				}

				if(kitItem.IsSelected)
				{
					SetControlValues(kitItem);
				}

				thisListItem.Selected = kitItem.IsSelected;
				ddlKitItems.Items.Add(thisListItem);
			}
			litStockHint.Text = AppLogic.AppConfigBool("KitInventory.ShowOutOfStockMessage") ? StockHint(KitGroup.Items[ddlKitItems.SelectedIndex]) : string.Empty;
		}

		public override void ResolveSelection()
		{
			foreach(ListItem lItem in ddlKitItems.Items)
			{
				int kitId = lItem.Value.ToNativeInt();
				KitItemData kitItem = KitGroup.GetItem(kitId);

				kitItem.IsSelected = lItem.Selected;
			}
		}

		private void SetControlValues(KitItemData kitItem)
		{
			pnlKitItemImage.Visible = kitItem.HasImage;
			imgKitItem.ImageUrl = kitItem.ImagePath;
			pnlKitItemDescription.Visible = kitItem.HasDescription;
			ltKitItemDescription.Text = kitItem.Description;
		}
	}
}
