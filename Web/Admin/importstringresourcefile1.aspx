<%@ Page Language="C#" AutoEventWireup="true" CodeFile="importstringresourcefile1.aspx.cs" Inherits="AspDotNetStorefrontAdmin.importstringresourcefile1" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<h1>
		<i class="fa fa-pencil-square-o"></i>
		<asp:Literal ID="litStage" runat="server" />
	</h1>
	<aspdnsf:AlertMessage ID="ctlAlertMessage" runat="server" />

	<asp:Panel ID="pnlUpload" runat="server" DefaultButton="btnSubmit">
		<div class="white-ui-box">
			<div class="white-box-heading">
				<asp:Literal ID="litUploadInstructions" runat="server" Text="<%$ Tokens:StringResource, admin.stringresources.UploadFile %>" />
			</div>
			<p>
				<asp:Literal ID="litSelectFileInstructions" runat="server" />
			</p>
			<div class="form-group">
				*<asp:Label runat="server" AssociatedControlID="fuMain" Text="<%$ Tokens:StringResource, admin.stringresources.File %>" />
				<asp:FileUpload ID="fuMain" CssClass="fileUpload" runat="server" />
				<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator" ControlToValidate="fuMain"
					ErrorMessage="Required" CssClass="text-danger" />
			</div>
			<div class="form-group">
				<asp:CheckBox ID="chkReplaceExisting" runat="server" Text="<%$ Tokens:StringResource, admin.stringresources.ReplaceExisting %>" />
				<asp:CheckBox ID="chkLeaveModified" runat="server" Text="<%$ Tokens:StringResource, admin.stringresources.LeaveModified %>" />
			</div>
		</div>

		<div class="item-action-bar">
			<asp:HyperLink ID="lnkBack1" runat="server" Text="<%$ Tokens:StringResource,admin.common.cancel %>" CssClass="btn btn-default"></asp:HyperLink>
			<asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="<%$Tokens:StringResource, admin.common.Upload %>"
				OnClick="btnSubmit_Click" />
		</div>
	</asp:Panel>

	<asp:Panel ID="pnlReload" runat="server" DefaultButton="btnReload">
		<div class="white-ui-box">
			<div class="white-box-heading">
				<asp:Literal runat="server" Text="<%$ Tokens:StringResource, admin.stringresources.ReloadFromServer %>" />
			</div>
			<div class="form-group">
				<asp:CheckBox ID="chkReloadReplaceExisting" runat="server" Text="<%$ Tokens:StringResource, admin.stringresources.ReplaceExisting %>" />
				<asp:CheckBox ID="chkReloadLeaveModified" runat="server" Text="<%$ Tokens:StringResource, admin.stringresources.LeaveModified %>" />
			</div>
		</div>
		<div class="item-action-bar">
			<asp:HyperLink ID="lnkBack2" runat="server" Text="<%$Tokens:StringResource, admin.common.cancel%>" CssClass="btn btn-default"></asp:HyperLink>
			<asp:Button ID="btnReload" CssClass="btn btn-primary" runat="server" Text="<%$Tokens:StringResource, admin.importstringresourcefile1.ReloadReview %>"
				OnClick="btnReload_Click" />
		</div>
	</asp:Panel>
</asp:Content>
