<%@ Page Language="c#" Inherits="AspDotNetStorefrontAdmin.entityBulkInventory" CodeFile="entitybulkinventory.aspx.cs" %>

<head runat="server">
	<script src="Scripts/jquery.min.js" type="text/javascript"></script>
	<script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
	<form runat="server">
		<aspdnsf:AlertMessage runat="server" ID="AlertMessageDisplay" />
		<asp:Panel runat="server" ID="MainBody" DefaultButton="TopBtnInventoryUpdate">
			<div class="item-action-bar">
				<asp:Button ID="topBtnInventoryUpdate" Text="Save Inventory" CssClass="btn btn-primary btn-sm" runat="server" OnClick="BtnInventoryUpdate_click" />
			</div>

			<asp:Literal ID="ltBody" runat="server" />
		
			<div class="item-action-bar">
				<asp:Button ID="bottomBtnInventoryUpdate" Text="Save Inventory" CssClass="btn btn-primary btn-sm" runat="server" OnClick="BtnInventoryUpdate_click" />
			</div>
		</asp:Panel>
	</form>
</body>
