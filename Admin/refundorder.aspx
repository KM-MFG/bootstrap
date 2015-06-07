<%@ Page Language="C#" AutoEventWireup="true" CodeFile="refundorder.aspx.cs" Inherits="AspDotNetStorefrontAdmin.refundorder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<script src="Scripts/jquery.min.js" type="text/javascript"></script>
	<script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
	<title></title>
</head>
<body class="body-tag main-content-wrapper" runat="server" id="refundBody">
	<form id="form1" runat="server">
		<asp:ScriptManager ID="ScriptManager1" runat="server" />
		<div class="container-fluid">
			<h1>
				<i class="fa fa-undo"></i>
				<asp:Label ID="lblHeader" runat="server" Text="<%$Tokens:StringResource, admin.title.refundorder %>" />
			</h1>
			<asp:UpdatePanel runat="server" UpdateMode="Always">
				<ContentTemplate>
					<div class="white-ui-box">
						<div>
							<aspdnsf:AlertMessage runat="server" ID="ctrlAlertMessage" />
						</div>
						<div>
							<aspdnsf:AlertMessage runat="server" ID="ctrlAlertMessageNoPermissions" />
						</div>
						<div runat="server" id="divAllowed">
							<div runat="server" id="divHasOrderNumber">
								<div class="row admin-row">
									<div class="col-sm-4">
										<asp:Label runat="server" AssociatedControlID="lblOrderNumber" Text="<%$Tokens:StringResource, admin.refund.FullyRefundOrder %>" />
									</div>
									<div class="col-sm-8">
										<asp:Label runat="server" ID="lblOrderNumber" />
									</div>
								</div>
								<div runat="server" id="refundForm">
									<input type="hidden" name="IsSubmit" value="true" />
									<div class="row admin-row">
										<div class="col-sm-4">
											<asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.refund.Reason%>" />
										</div>
										<div class="col-sm-8">
											<input type="text" class="text-lg" maxlength="100" onkeypress="javascript:return WebForm_FireDefaultButton(event, 'btnyes')" name="RefundReason" />
										</div>
									</div>
								</div>
							</div>
							<div runat="server" id="divIncorrectOrderNumber">
								<aspdnsf:AlertMessage runat="server" ID="ctrlAlertMessageIncorrectOrderNumber" />
							</div>
						</div>
					</div>
					<div class="item-action-bar">
						<div class="col-list-action-bar">
							<asp:Button ID="btnCancel" runat="server" CssClass="btn btn-default" OnClientClick="javascript:self.close();return false;" />
							<asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" OnClientClick="return PostForm();" Text="<%$Tokens:StringResource, admin.refund.ProcessRefund %>" Visible="false" />
						</div>
					</div>
					<asp:Literal ID="litRefresh" runat="server" />
				</ContentTemplate>
			</asp:UpdatePanel>
		</div>
		<script type="text/javascript">
			function PostForm() {
				if (confirm('<%=AspDotNetStorefrontCore.AppLogic.GetString("admin.refund.RefundConfirm",ThisCustomer.LocaleSetting)%>')) {
					$.post("refundorder.aspx").done(function(data) {
						window.opener.location.href = '<%=string.Format("{0}?ordernumber={1}", AspDotNetStorefrontCore.AppLogic.AdminLinkUrl("order.aspx"), OrderNumber)%>';						
					});
					return true;
				}
				else {
					return false;
				}
			}
		</script>
	</form>
</body>
</html>