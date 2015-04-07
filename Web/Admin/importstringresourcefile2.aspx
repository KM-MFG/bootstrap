<%@ Page Language="C#" AutoEventWireup="true" CodeFile="importstringresourcefile2.aspx.cs" Inherits="AspDotNetStorefrontAdmin.importstringresourcefile2"
	MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<asp:Literal ID="ltScript" runat="server"></asp:Literal>
	<asp:Literal ID="ltValid" runat="server"></asp:Literal>
	<h1>
		<i class="fa fa-pencil-square-o"></i>
		<asp:Literal runat="server" Text="<%$ Tokens:StringResource, admin.stringresources.VerifyFile %>" />
	</h1>
	<div id="help">
		<div style="margin-bottom: 5px; margin-top: 5px;">
			<asp:Literal ID="ltError" runat="server"></asp:Literal>
		</div>
	</div>
	<div class="white-ui-box">
		<asp:Literal ID="ltProcessing" runat="server"></asp:Literal>
		<asp:Panel runat="server" ID="ActionsPanel" CssClass="form-group">
			<asp:Literal ID="ltVerify" runat="server" Text="<%$Tokens:StringResource, admin.importstringresourcefile2.Good %>"></asp:Literal>
			<asp:LinkButton ID="btnProcessFile" runat="Server" OnClick="btnProcessFile_Click" CssClass="btn btn-primary"></asp:LinkButton>
			<asp:HyperLink ruant="server" ID="CancelLink" runat="server" CssClass="btn btn-default" Text="<%$Tokens:StringResource, admin.importstringresourcefile2.CancelReload %>" />
		</asp:Panel>
		<asp:Literal runat="server" ID="ltData"></asp:Literal>
	</div>

</asp:Content>
