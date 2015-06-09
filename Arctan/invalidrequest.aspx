<%@ Page Language="C#" AutoEventWireup="true" CodeFile="invalidrequest.aspx.cs" Inherits="AspDotNetStorefrontAdmin.Admin_InvalidRequest" MasterPageFile="~/App_Templates/Admin_Default/Popup.master" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<div class="error-page-message">
		<p>
			<a class="error-page-icon text-danger" href="systemlogs.aspx" target="_blank">
				<i class="fa fa-exclamation-triangle"></i>
			</a>
		</p>
		<p class="error-page-text">
			<asp:Label ID="Label2" runat="server" Text="<%$ Tokens:StringResource, admin.InvalidRequest.aspx.1 %>" />
		</p>
	</div>
</asp:Content>