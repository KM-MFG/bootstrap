<%@ Page Language="C#" AutoEventWireup="true" CodeFile="entityproductbulkdisplayorder.aspx.cs" Inherits="AspDotNetStorefrontAdmin.Admin_entityProductBulkDisplayOrder" Theme="Admin_Default" %>

<html>
<head id="Head1" runat="server">
	<script src="Scripts/jquery.min.js" type="text/javascript"></script>
	<script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
</head>

<body>
	<form id="frmEntityBulk" runat="server">
		<aspdnsf:AlertMessage runat="server" ID="AlertMessage" />
		<asp:Panel ID="MainBody" runat="server" DefaultButton="SubmitButton">
			<div class="item-action-bar">
				<asp:Button runat="server" ID="SubmitButton" Text="Save Display Order" CssClass="btn btn-primary btn-sm" />
			</div>

			<asp:Literal ID="ltBody" runat="server"></asp:Literal>

			<div class="item-action-bar">
				<asp:Button runat="server" ID="SubmitButtonBottom" Text="Save Display Order" CssClass="btn btn-primary btn-sm" />
			</div>
		</asp:Panel>
	</form>
</body>
</html>
