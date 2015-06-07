<%@ Page Language="C#" AutoEventWireup="true" CodeFile="inventorycontrol.aspx.cs" Inherits="AspDotNetStorefrontAdmin._InventoryControl" MaintainScrollPositionOnPostback="true" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxToolkit" %>
<%@ Register TagPrefix="aspdnsf" TagName="AppConfigInfo" Src="controls/appconfiginfo.ascx" %>
<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<h1>
		<i class="fa fa-tasks"></i>
		<asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.menu.InventoryControl %>" />
	</h1>
	<div>
		<aspdnsf:AlertMessage runat="server" ID="ctrlAlertMessage" />
	</div>
	<div class="item-action-bar">
		<asp:Button ID="btnUpdateTop" runat="server" OnClick="btnUpdate_Click" CssClass="btn btn-primary" Text="<%$Tokens:StringResource, admin.common.Save %>" />
	</div>
	<asp:Panel ID="pnlLocale" runat="server">
		<div class="item-action-bar">
			<div class="other-actions">
				<asp:Label AssociatedControlID="ddlLocale" runat="server" Text="<%$Tokens:StringResource, admin.common.Locale %>" />
				<asp:DropDownList ID="ddlLocale" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocale_SelectedIndexChanged" />
			</div>
		</div>
	</asp:Panel>
	<div class="white-ui-box">
		<div class="white-box-heading">
			<asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.wizard.appconfigwarning %>" />
		</div>
		<div class="form-group">
			<div class="row admin-row">
				<div class="col-sm-4">
					<asp:Label runat="server" AssociatedControlID="chkLimitCartToQuantityOnHand" Text="<%$Tokens:StringResource, admin.InventoryControl.LimitCartInQuantityInHand %>" />
					<aspdnsf:AppConfigInfo AppConfigName="Inventory.LimitCartToQuantityOnHand" runat="server" />
				</div>
				<div class="col-sm-8">
					<asp:CheckBox ID="chkLimitCartToQuantityOnHand" runat="server" />
				</div>
			</div>
			<div class="row admin-row">
				<div class="col-sm-4">
					<span class="text-danger">*</span><asp:Label runat="server" AssociatedControlID="txtHideProductsWithLessThanThisInventoryLevel" Text="<% $Tokens:StringResource, admin.InventoryControl.HideProductsWithLessThanThisInventoryLevel %>" />
					<aspdnsf:AppConfigInfo AppConfigName="HideProductsWithLessThanThisInventoryLevel" runat="server" />
				</div>
				<div class="col-sm-8">
					<asp:TextBox CssClass="form-control text-md" ID="txtHideProductsWithLessThanThisInventoryLevel" runat="server" MaxLength="5" />
					<asp:CompareValidator runat="server" CssClass="text-danger validator-error-adjustments" Display="Dynamic" ErrorMessage="<%$Tokens:StringResource, admin.editquantitydiscounttable.EnterInteger %>" ControlToValidate="txtHideProductsWithLessThanThisInventoryLevel" Operator="DataTypeCheck" Type="Integer" />
					<asp:RequiredFieldValidator runat="server" CssClass="text-danger validator-error-adjustments" Display="Dynamic" ErrorMessage="<%$Tokens:StringResource, admin.InventoryControl.EnterGreaterThan0 %>" ControlToValidate="txtHideProductsWithLessThanThisInventoryLevel" />
				</div>
			</div>
			<div class="row admin-row">
				<div class="col-sm-4">
					<asp:Label runat="server" AssociatedControlID="chkProductPageOutOfStockRedirect" Text="<% $Tokens:StringResource, admin.InventoryControl.ProductPageOutOfStockRedirect %>" />
					<aspdnsf:AppConfigInfo AppConfigName="ProductPageOutOfStockRedirect" runat="server" />
				</div>
				<div class="col-sm-8">
					<asp:CheckBox ID="chkProductPageOutOfStockRedirect" runat="server" />
				</div>
			</div>
		</div>
	</div>
	<div class="white-ui-box">
		<div class="white-box-heading">
			<asp:Literal ID="Literal1" runat="server" Text="<%$Tokens:StringResource, admin.InventoryControl.OutOfStockMessageOptions %>" />
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="chkDisplayOutOfStockMessage" Text="<% $Tokens:StringResource, admin.InventoryControl.DisplayOutOfStockProducts %>" />
				<aspdnsf:AppConfigInfo AppConfigName="DisplayOutOfStockProducts" runat="server" />
			</div>
			<div class="col-sm-8">
				<asp:CheckBox ID="chkDisplayOutOfStockMessage" runat="server" />
			</div>
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<span class="text-danger">*</span><asp:Label ID="lblOutOfStockThreshold" AssociatedControlID="txtOutOfStockThreshold" runat="server" Text="<% $Tokens:StringResource, admin.InventoryControl.OutOfStockThreshold %>" />
				<aspdnsf:AppConfigInfo AppConfigName="OutOfStockThreshold" runat="server" />
			</div>
			<div class="col-sm-8">
				<asp:TextBox ID="txtOutOfStockThreshold" CssClass="form-control text-md" runat="server" MaxLength="5" />
				<asp:CompareValidator runat="server" CssClass="text-danger validator-error-adjustments" ControlToValidate="txtOutOfStockThreshold" CultureInvariantValues="True" ErrorMessage="<%$Tokens:StringResource, admin.InventoryControl.InputNumber %>" Display="Dynamic" Operator="DataTypeCheck" Type="Integer" />
				<asp:RequiredFieldValidator runat="server" CssClass="text-danger validator-error-adjustments" Display="Dynamic" ErrorMessage="<%$Tokens:StringResource, admin.InventoryControl.InputNumber %>" ControlToValidate="txtOutOfStockThreshold" />
			</div>
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="txtProductOutOfStockMessage" Text="<%$Tokens:StringResource, admin.InventoryControl.ProductOutOfStockMessage %>" />
				<asp:Label runat="server" CssClass="hover-help" data-toggle="tooltip" ToolTip="<%$ Tokens:StringResource, admin.InventoryControl.Tooltip.ProductOutOfStockMessage %>">
					<i class="fa fa-question-circle fa-lg"></i>
				</asp:Label>
			</div>
			<div class="col-sm-8">
				<asp:TextBox CssClass="form-control text-md" ID="txtProductOutOfStockMessage" runat="server" />
			</div>
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="txtEntityOutOfStockMessage" Text="<%$Tokens:StringResource, admin.InventoryControl.EntityOutOfStockMessage %>" />
				<asp:Label runat="server" CssClass="hover-help" data-toggle="tooltip" ToolTip="<%$ Tokens:StringResource, admin.InventoryControl.Tooltip.EntityOutOfStockMessage %>">
					<i class="fa fa-question-circle fa-lg"></i>
				</asp:Label>
			</div>
			<div class="col-sm-8">
				<asp:TextBox CssClass="form-control text-md" ID="txtEntityOutOfStockMessage" runat="server" />
			</div>
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="txtProductInStockMessage" Text="<%$Tokens:StringResource, admin.InventoryControl.ProductInStockMessage %>" />
				<asp:Label runat="server" CssClass="hover-help" data-toggle="tooltip" ToolTip="<%$ Tokens:StringResource, admin.InventoryControl.Tooltip.ProductInStockMessage %>">
					<i class="fa fa-question-circle fa-lg"></i>
				</asp:Label>
			</div>
			<div class="col-sm-8">
				<asp:TextBox CssClass="form-control text-md" ID="txtProductInStockMessage" runat="server" />
			</div>
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="txtEntityInStockMessage" Text="<%$Tokens:StringResource, admin.InventoryControl.EntityInStockMessage %>" />
				<asp:Label runat="server" CssClass="hover-help" data-toggle="tooltip" ToolTip="<%$ Tokens:StringResource, admin.InventoryControl.Tooltip.EntityInStockMessage %>">
					<i class="fa fa-question-circle fa-lg"></i>
				</asp:Label>
			</div>
			<div class="col-sm-8">
				<asp:TextBox CssClass="form-control text-md" ID="txtEntityInStockMessage" runat="server" />
			</div>
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="chkShowOutOfStockMessageOnProductPages" Text="<%$Tokens:StringResource, admin.InventoryControl.ShowInProductPages %>" />
				<aspdnsf:AppConfigInfo AppConfigName="DisplayOutOfStockOnProductPages" runat="server" />
			</div>
			<div class="col-sm-8">
				<asp:CheckBox ID="chkShowOutOfStockMessageOnProductPages" runat="server" />
			</div>
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="chkShowOutOfStockMessageOnEntityPages" Text="<%$Tokens:StringResource, admin.InventoryControl.ShowInEntityPages %>" />
				<aspdnsf:AppConfigInfo AppConfigName="DisplayOutOfStockOnEntityPages" runat="server" />
			</div>
			<div class="col-sm-8">
				<asp:CheckBox ID="chkShowOutOfStockMessageOnEntityPages" runat="server" />
			</div>
		</div>
	</div>
	<div class="white-ui-box">
		<div class="white-box-heading">
			<asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.InventoryControl.KitInventoryOptions %>" />
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="rdbShowOutOfStockMessage" Text="<%$Tokens:StringResource, admin.InventoryControl.Kits.ShowOutOfStock %>" />
				<aspdnsf:AppConfigInfo AppConfigName="KitInventory.ShowOutOfStockMessage" runat="server" />
			</div>
			<div class="col-sm-8">
				<asp:RadioButtonList ID="rdbShowOutOfStockMessage" runat="server" RepeatColumns="2" RepeatDirection="horizontal" RepeatLayout="Flow">
					<asp:ListItem Value="true" Text="Yes" />
					<asp:ListItem Value="false" Text="No" />
				</asp:RadioButtonList>
			</div>
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="rblAllowSaleOfOutOfStock" Text="<%$Tokens:StringResource, admin.InventoryControl.Kits.AllowSaleOfOutOfStock %>" />
				<aspdnsf:AppConfigInfo AppConfigName="KitInventory.AllowSaleOfOutOfStock" runat="server" />
			</div>
			<div class="col-sm-8">
				<asp:RadioButtonList ID="rblAllowSaleOfOutOfStock" runat="server" RepeatColumns="2" RepeatDirection="horizontal" RepeatLayout="Flow">
					<asp:ListItem Value="true" Text="Yes" />
					<asp:ListItem Value="false" Text="No" />
				</asp:RadioButtonList>
			</div>
		</div>
		<div class="row admin-row">
			<div class="col-sm-4">
				<asp:Label runat="server" AssociatedControlID="txtKitItemOutOfStockSellAnyway" Text="<%$Tokens:StringResource, admin.InventoryControl.KitItemOutOfStockSellAnyway %>" />
				<asp:Label runat="server" CssClass="hover-help" data-toggle="tooltip" ToolTip="<%$ Tokens:StringResource, admin.InventoryControl.Tooltip.KitItemOutOfStockSellAnyway %>">
					<i class="fa fa-question-circle fa-lg"></i>
				</asp:Label>
			</div>
			<div class="col-sm-8">
				<asp:TextBox CssClass="form-control text-md" ID="txtKitItemOutOfStockSellAnyway" runat="server" />
			</div>
		</div>
	</div>
	<div class="item-action-bar">
		<asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" CssClass="btn btn-primary" Text="<%$Tokens:StringResource, admin.common.Save %>" />
	</div>
</asp:Content>