<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signin.aspx.cs" Inherits="signin" Theme="Admin_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>AspDotNetStorefront Admin for Store:<asp:Literal ID="ltStoreName" runat="server"></asp:Literal></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<asp:Literal runat="server" ID="literalSelfReloadScript"></asp:Literal>
	<script src="Scripts/jquery.min.js" type="text/javascript"></script>
	<script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body class="loginbody background-key">

	<script type="text/javascript">
		if (top != self) {
			top.location = self.location;
		}
	</script>
	<form id="SigninForm" runat="server">
		<div class="container-fluid login-container">
			<div class="row login-panel-row">
				<div class="login-panel">
					<div class="login-logo">
						<asp:Image ID="imglogo" ImageUrl="~/App_Themes/Admin_Default/images/aspdnsf-logo.png" runat="server" />
					</div>
					<div class="white-ui-box">
						<div class="admin-heading">Admin Login</div>
						<div class="login-area">
							<asp:Panel ID="pnlSignIn" runat="server" DefaultButton="btnSubmit" Visible="true">
								<asp:Panel ID="loginError" runat="server" CssClass="alert alert-danger" Visible="false">
									<asp:Literal ID="ltError" runat="Server" />
								</asp:Panel>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-5">
											<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, signin.aspx.10 %>" />
										</div>
										<div class="col-sm-7">
											<asp:TextBox ID="txtEMail" runat="server" CssClass="form-control login-field" CausesValidation="True" />
											<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEMail" ErrorMessage="<%$Tokens:StringResource, admin.common.EmailRequired %>" SetFocusOnError="True" ValidationGroup="LOGIN" Display="Dynamic" CssClass="text-danger" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-5">
											<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, signin.aspx.12 %>" />
										</div>
										<div class="col-sm-7">
											<asp:TextBox ID="txtPassword" TextMode="password" CssClass="form-control" runat="server" EnableViewState="False" CausesValidation="True" />
											<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPassword" ErrorMessage="<%$Tokens:StringResource, admin.common.PasswordRequired %>" SetFocusOnError="True" ValidationGroup="LOGIN" Display="Dynamic" CssClass="text-danger" />
										</div>
									</div>
								</div>
								<div id="RowSecurityCode" runat="server" visible="false" class="form-group">
									<div class="row">
										<div class="col-sm-5">
											<span class="text-danger">*</span><asp:Label ID="SecurityCodeLabel" runat="server" Visible="False" />
										</div>
										<div class="col-sm-7">
											<asp:TextBox ID="SecurityCode" runat="server" Visible="False" CausesValidation="True" EnableViewState="False" CssClass="form-control" />&nbsp;
											<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="SecurityCode" ErrorMessage="<%$Tokens:StringResource, signin.aspx.20 %>" ValidationGroup="LOGIN" Display="Dynamic" CssClass="text-danger" />
											<div id="RowSecurityImage" runat="server" visible="false">
												<asp:Image ID="SecurityImage" runat="server" Visible="False" />
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-7 col-sm-offset-5">
										<div class="form-group">
											<asp:Button ID="btnSubmit" Text="<%$ Tokens:StringResource,signin.aspx.19 %>" runat="Server" OnClick="btnSubmit_Click" ValidationGroup="LOGIN" CssClass="btn btn-primary" />
										</div>
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlChangePWForButton" runat="server" DefaultButton="btnRequestNewPassword">
								<div class="admin-heading">
									<asp:Label runat="server" Text="<%$Tokens:StringResource, signin.aspx.15 %>" />
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-5">
											<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, signin.aspx.10 %>"></asp:Label>
										</div>
										<div class="col-sm-7">
											<asp:TextBox ID="txtEMailRemind" runat="Server" CausesValidation="True" CssClass="form-control"></asp:TextBox>
											<asp:Label runat="server" CssClass="hover-help" data-toggle="tooltip" ToolTip="<%$ Tokens:StringResource, signin.aspx.16 %>">
												<i class="fa fa-question-circle fa-lg"></i>
											</asp:Label>
											<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEMailRemind" ErrorMessage="<%$ Tokens:StringResource, admin.common.EmailRequired %>" CssClass="text-danger" SetFocusOnError="True" ValidationGroup="FORGOT" Display="Dynamic"></asp:RequiredFieldValidator>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-7 col-sm-offset-5">
											<asp:Button ID="btnRequestNewPassword" OnClick="btnRequestNewPassword_Click" Text="<%$ Tokens:StringResource, signin.aspx.RequestNewPassword %>" ValidationGroup="FORGOT" runat="Server" CssClass="btn btn-default"></asp:Button>
										</div>
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlChangePwd" runat="server" Visible="false" DefaultButton="btnChangePwd">
								<asp:Panel ID="pnlPwdChgErrMsg" runat="server" CssClass="alert alert-danger" Visible="false">
									<asp:Label ID="lblPwdChgErrMsg" runat="server"></asp:Label>
								</asp:Panel>
								<h4>
									<asp:Label ID="lblChgPwdHeader" Text="Change Password" runat="server"></asp:Label>
								</h4>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-5">
											<span class="text-danger">*</span><asp:Label ID="lblChgPwdEmail" runat="server" Text="Email Address:"></asp:Label>
										</div>
										<div class="col-sm-7">
											<asp:TextBox ID="txtEmailNewPwd" runat="server" CssClass="form-control"></asp:TextBox>
											<asp:RequiredFieldValidator ID="rfdChangeEmailRequired" runat="server" ControlToValidate="txtEmailNewPwd" ErrorMessage="<%$ Tokens:StringResource, admin.common.EmailRequired %>" CssClass="text-danger" SetFocusOnError="True" ValidationGroup="change" Display="Dynamic" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-5">
											<span class="text-danger">*</span><asp:Label ID="lblOldPwd" runat="server" Text="Old Password:"></asp:Label>
										</div>
										<div class="col-sm-7">
											<asp:TextBox ID="txtOldPwd" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
											<asp:RequiredFieldValidator ID="rfvOldPWRequired" runat="server" ControlToValidate="txtOldPwd" ErrorMessage="<%$ Tokens:StringResource, admin.common.oldPWRequired %>" CssClass="text-danger" SetFocusOnError="True" ValidationGroup="change" Display="Dynamic" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-5">
											<span class="text-danger">*</span><asp:Label ID="lblNewPwd" runat="server" Text="New Password:"></asp:Label>
										</div>
										<div class="col-sm-7">
											<asp:TextBox ID="txtNewPwd" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
											<asp:RequiredFieldValidator ID="rfvNewPWRequired" runat="server" ControlToValidate="txtNewPwd" ErrorMessage="<%$ Tokens:StringResource, admin.common.newPWRequired %>" CssClass="text-danger" SetFocusOnError="True" ValidationGroup="change" Display="Dynamic" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-5">
											<span class="text-danger">*</span><asp:Label ID="lblConfirmPwd" runat="server" Text="Confirm Password:"></asp:Label>
										</div>
										<div class="col-sm-7">
											<asp:TextBox ID="txtConfirmPwd" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
											<asp:RequiredFieldValidator ID="rfvConfimPWRequired" runat="server" ControlToValidate="txtConfirmPwd" ErrorMessage="<%$ Tokens:StringResource, admin.common.ConfirmPWRequired %>" CssClass="text-danger" SetFocusOnError="True" ValidationGroup="change" Display="Dynamic" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-7 col-sm-offset-5">
											<asp:Button Text="Change Password" ID="btnChangePwd" runat="Server" OnClick="btnChangePwd_OnClick" ValidationGroup="change" CssClass="btn btn-primary"></asp:Button>
										</div>
									</div>
								</div>
							</asp:Panel>
						</div>
					</div>
					<asp:ValidationSummary ID="validationSummary" runat="server" EnableClientScript="true" ShowMessageBox="true" ShowSummary="false" Enabled="true" ValidationGroup="vgLogin" />
					<asp:ValidationSummary ID="ValidationSummary1" runat="server" EnableClientScript="true" ShowMessageBox="true" ShowSummary="false" Enabled="true" ValidationGroup="vgPassword" />
				</div>
			</div>
		</div>
	</form>
	<script src="Scripts/bootstrapextensions.js" type="text/javascript"></script>
</body>
</html>