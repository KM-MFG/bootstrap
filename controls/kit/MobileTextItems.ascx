<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MobileTextItems.ascx.cs" Inherits="AspDotNetStorefront.Kit.MobileTextItems" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Import Namespace="AspDotNetStorefrontCore" %>

<asp:Repeater ID="rptItems" runat="server" DataSource='<%# KitGroup.SelectableItems %>' OnItemDataBound="rptItems_ItemDataBound">
	<ItemTemplate>
		<asp:HiddenField ID="hdfKitItemId" runat="server" Value='<%# Container.DataItemAs<KitItemData>().Id %>' />
		<asp:Label ID="lblItemName" runat="server"
			CssClass='<%# this.CssClassIf(Container.DataItemAs<KitItemData>().HasImage, "kit-group-item-name-label") %>'
			Text='<%# KitItemDisplayText(Container.DataItemAs<KitItemData>()) %>' />
		<asp:Literal ID="litStockHint" runat="server" Text='<%# StockHint(Container.DataItemAs<KitItemData>()) %>' />
		<asp:Panel ID="pnlCollapsible" runat="server">
			<asp:Panel ID="pnlKitItemImage" runat="server" Visible='<%# Container.DataItemAs<KitItemData>().HasImage %>'>
				<asp:Image ID="imgKitItem" runat="server" CssClass="kit-group-item-image" ImageUrl='<%# Container.DataItemAs<KitItemData>().ImagePath %>' />
			</asp:Panel>
			<asp:Panel ID="pnlKitItemDescription" runat="server" Visible='<%# Container.DataItemAs<KitItemData>().HasDescription %>'>
				<asp:Literal ID="ltKitItemDescription" runat="server" Text='<%# Container.DataItemAs<KitItemData>().Description %>' />
			</asp:Panel>
		</asp:Panel>
		<ajax:CollapsiblePanelExtender ID="extCollapseImage" runat="server"
			TargetControlID="pnlCollapsible"
			CollapseControlID="lblItemName"
			ExpandControlID="lblItemName"
			Collapsed="true">
		</ajax:CollapsiblePanelExtender>
		<div>
			<asp:TextBox ID="txtKitItemText" runat="server"
				AutoPostBack="true"
				TextMode='<%# DetermineTextMode() %>'
				Text='<%# Container.DataItemAs<KitItemData>().TextOption %>'
				CssClass="form-control"
				Enabled='<%# Container.DataItemAs<KitItemData>().CanBeSelected %>'>
			</asp:TextBox>
		</div>
	</ItemTemplate>
</asp:Repeater>