<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DropDownListItems.ascx.cs" Inherits="AspDotNetStorefront.Kit.DropDownListItems" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Import Namespace="AspDotNetStorefrontCore" %>

<asp:DropDownList ID="ddlKitItems" CssClass="form-control" runat="server" AutoPostBack="true" />
<asp:Literal ID="litStockHint" runat="server" />
<asp:Panel ID="pnlKitItemImage" runat="server">
	<asp:Image ID="imgKitItem" runat="server" CssClass="kit-group-item-image" />
</asp:Panel>
<asp:Panel ID="pnlKitItemDescription" runat="server">
	<asp:Literal ID="ltKitItemDescription" runat="server" />
</asp:Panel>