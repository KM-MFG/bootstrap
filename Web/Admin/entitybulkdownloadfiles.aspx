<%@ Page Language="c#" Inherits="AspDotNetStorefrontAdmin.entityBulkDownloadFiles" CodeFile="entitybulkdownloadfiles.aspx.cs" %>

<head runat="server">
	<script src="Scripts/jquery.min.js" type="text/javascript"></script>
	<script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
	<form runat="server">
		<aspdnsf:AlertMessage runat="server" ID="AlertMessage" />
		<asp:Panel runat="server" ID="MainBody" DefaultButton="btnSubmit">
			<div class="item-action-bar">
				<asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-primary btn-sm" Text="<%$Tokens:StringResource, admin.entityBulkDownloadFiles.DownloadUpdate %>" />
			</div>
			<asp:Literal ID="ltBody" runat="server" />
			<div class="item-action-bar">
				<asp:Button runat="server" ID="btnSubmitBottom" CssClass="btn btn-primary btn-sm" Text="<%$Tokens:StringResource, admin.entityBulkDownloadFiles.DownloadUpdate %>" />
			</div>
		</asp:Panel>
	</form>
</body>
