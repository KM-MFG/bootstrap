<%@ Page Language="c#" Inherits="AspDotNetStorefrontAdmin.changeencryptkey" CodeFile="changeencryptkey.aspx.cs"
	EnableEventValidation="false" MaintainScrollPositionOnPostback="true" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<h1>
		<i class="fa fa-wrench"></i>
		<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.title.changeencryptkey %>" />
	</h1>
	<div class="alert alert-danger">
		<asp:Label ID="Label6" runat="server" Text="<%$Tokens:StringResource, admin.changeencryptkey.Backup %>" />
	</div>
	<asp:UpdatePanel runat="server">
		<ContentTemplate>
			<aspdnsf:AlertMessage ID="ctlAlertMessage" runat="server" />
		</ContentTemplate>
	</asp:UpdatePanel>
	<div class="white-ui-box">
		<p>
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.changeencryptkey.Recommendation %>" />
		</p>
		<p>
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.changeencryptkey.StoringCreditCards %>" />
			<asp:Label ID="StoringCC" runat="server" Font-Bold="True"></asp:Label>
		</p>
		<p>
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.changeencryptkey.RequireCreditCardStorage %>" />
			<asp:Label ID="RecurringProducts" runat="server" Font-Bold="True"></asp:Label>
		</p>
		<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.changeencryptkey.Reminder %>" />
		<asp:Panel runat="server" ID="DoItPanel" Width="100%" DefaultButton="btnUpdateEncryptKey">
			<p>
				<asp:UpdatePanel ID="updPnlChangeEncryptKey" runat="server">
					<ContentTemplate>
						<h4>
							<asp:Literal ID="ltChangeEncryptKey" runat="server" Text="<%$ Tokens:StringResource, admin.changeencrypt.ChangeEncryptKey %>" />
							<asp:RadioButtonList ID="rblChangeEncryptKey" runat="server" OnSelectedIndexChanged="rblChangeEncryptKey_OnSelectedIndexChanged" AutoPostBack="true">
								<asp:ListItem Value="true" Text="<%$Tokens:StringResource, admin.common.yes %>"></asp:ListItem>
								<asp:ListItem Value="false" Text="<%$Tokens:StringResource, admin.common.no %>"></asp:ListItem>
							</asp:RadioButtonList>
						</h4>
						<asp:Panel ID="pnlChangeEncryptKeyMaster" runat="server" Visible="false">
							<strong>
								<asp:Label ID="Label5" runat="server" Text="<%$Tokens:StringResource, admin.changeencryptkey.BePatient %>" /></strong><br />
							<br />
							<asp:Literal ID="ltEncryptKeyGeneration" runat="server" Text="<%$ Tokens:StringResource,admin.changeencrypt.EncryptKeyGeneration %>" />
							<asp:Label runat="server" CssClass="hover-help" data-toggle="tooltip" ToolTip="<%$ Tokens:StringResource, admin.changeencrypt.tooltip.imgEncryptKeyGeneration %>">
								<i class="fa fa-question-circle fa-lg"></i>
							</asp:Label>
							<asp:RadioButtonList ID="rblEncryptKeyGenType" runat="server" AutoPostBack="true"
								OnSelectedIndexChanged="rblEncryptKeyGenType_OnSelectedIndexChanged">
								<asp:ListItem Value="auto" Text="<%$ Tokens:StringResource, admin.changeencrypt.Auto %>" />
								<asp:ListItem Value="manual" Text="<%$ Tokens:StringResource, admin.changeencrypt.Manual %>" />
							</asp:RadioButtonList>							
							<asp:Panel runat="server" ID="pnlEncryptKey" Visible="false">
								<br />
								<asp:Label ID="Label1" runat="server" Text="<%$Tokens:StringResource, admin.changeencryptkey.AtLeast %>" />
								<br />
								<br />
								<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.changeencrypt.NewEncryptKey %>" />
								<asp:TextBox ID="NewEncryptKey" runat="server" Width="317px" MaxLength="50">
								</asp:TextBox>
							</asp:Panel>
						</asp:Panel>
					</ContentTemplate>
				</asp:UpdatePanel>
			</p>
			<p>
				<asp:UpdatePanel ID="updPnlChangeMachineKey" runat="server">
					<ContentTemplate>
						<h4>
							<asp:Literal ID="ltChangeSetMachineKey" runat="server" Text="<%$ Tokens:StringResource, admin.changeencrypt.SetChangeMachineKey %>" />
							<asp:RadioButtonList ID="rblChangeMachineKey" runat="server" OnSelectedIndexChanged="rblChangeMachineKey_OnSelectedIndexChanged" AutoPostBack="true">
								<asp:ListItem Value="true" Text="<%$Tokens:StringResource, admin.common.yes %>"></asp:ListItem>
								<asp:ListItem Value="false" Text="<%$Tokens:StringResource, admin.common.no %>"></asp:ListItem>
							</asp:RadioButtonList>
						</h4>
						<asp:Panel ID="pnlChangeSetMachineKey" runat="server" Visible="false">
							<asp:Literal ID="ltMachineKeyGeneration" runat="server" Text="<%$ Tokens:StringResource,admin.changeencrypt.MachineKeyGeneration %>" />
							<asp:Label runat="server" CssClass="hover-help" data-toggle="tooltip" ToolTip="<%$ Tokens:StringResource, admin.changeencrypt.tooltip.imgMachineKeyGeneration %>">
								<i class="fa fa-question-circle fa-lg"></i>
							</asp:Label>
							<asp:RadioButtonList ID="rblMachineKeyGenType" runat="server" AutoPostBack="true"
								OnSelectedIndexChanged="rblMachineKeyGenType_OnSelectedIndexChanged">
								<asp:ListItem Value="auto" Text="<%$ Tokens:StringResource, admin.changeencrypt.Auto %>" />
								<asp:ListItem Value="manual" Text="<%$ Tokens:StringResource, admin.changeencrypt.Manual %>" />
							</asp:RadioButtonList>							
							<asp:Panel runat="server" ID="pnlMachineKey" Visible="false">
								<br />
								<asp:Label ID="lblMachineKeyLength" runat="server" Text="<%$Tokens:StringResource, admin.changeencryptkey.MachineKeyAtLeast %>" />
								<br />
								<br />
								<asp:Label ID="lblEnterValidationKey" runat="server" Text="<%$Tokens:StringResource, admin.changeencrypt.NewValidationKey %>" />
								<asp:TextBox ID="txtValidationKey" runat="server" Width="317px" MaxLength="64" />
								<br />
								<asp:Label ID="lblEnterDecryptKey" runat="server" Text="<%$Tokens:StringResource, admin.changeencrypt.NewDecryptKey %>" />
								<asp:TextBox ID="txtDecryptKey" runat="server" Width="317px" MaxLength="32" />
							</asp:Panel>
						</asp:Panel>
					</ContentTemplate>
				</asp:UpdatePanel>
			</p>
		</asp:Panel>
	</div>
	<asp:UpdatePanel runat="server">
		<ContentTemplate>
			<div id="pnlUpdateEncryptKey" runat="server" class="item-action-bar">
				<asp:Button ID="btnUpdateEncryptKey" runat="server" CssClass="btn btn-primary" OnClick="btnUpdateEncryptKey_Click" Text="<%$Tokens:StringResource, admin.changeencrypt.UpdateEncryptKey %>" />
			</div>
		</ContentTemplate>
	</asp:UpdatePanel>
</asp:Content>