<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PageNotFound.aspx.cs" Inherits="AspDotNetStorefront.PageNotFound" MasterPageFile="~/App_Templates/Admin_Default/Popup.master" Theme="Admin_Default" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<div class="error-page-message">
		<p class="error-page-icon text-danger">
			<i class="fa fa-exclamation-triangle"></i>
		</p>
		<p class="error-page-text">
			<asp:Label ID="Label2" runat="server" Text="<%$ Tokens:StringResource, admin.PageNotFound %>" />
		</p>
	</div>
</asp:Content>