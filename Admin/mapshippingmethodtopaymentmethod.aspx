<%@ Page Language="C#" AutoEventWireup="true" CodeFile="mapshippingmethodtopaymentmethod.aspx.cs" Inherits="AspDotNetStorefrontAdmin.MapShippingMethodToPaymentMethod" MaintainScrollPositionOnPostback="true" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<h1>
		<i class="fa fa-anchor"></i>
		<asp:Literal ID="litHeader" runat="server" Text="<%$Tokens:StringResource, admin.title.MapShippingMethodToPaymentMethod %>" />
	</h1>
	<a href="shippingmethods.aspx">Back to Shipping Methods</a>
	<div id="help">
		<div>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toppage">
				<tr>
					<td align="left" valign="middle">
						<div class="wrapper">
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div style="margin-bottom: 5px; margin-top: 5px;">
			<asp:Literal ID="ltError" runat="server"></asp:Literal>
		</div>
	</div>
	<aspdnsf:AlertMessage ID="ctlAlertMessage" runat="server" />
	<div id="content" class="white-ui-box">
		<div style="padding-bottom: 15px;">
			<asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.Info %>" />
		</div>
		<table border="0" cellpadding="1" cellspacing="0" class="">
			<tr>
				<td style="width: 669px">
					<div class="wrapper">
						<table border="0" cellpadding="0" cellspacing="0" class="">
							<tr>
								<td class="tablenormal">
									<font class="subTitle"><asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.AvailableShippingMethods %>" /></font>
								</td>
								<td class="tablenormal">
									<font class="subTitle"><asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.AvailablePaymentMethods %>" /></font>
								</td>
								<td class="tablenormal" style="width: 65px">
									<font class="subTitle"><asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.common.Move %>" /></font>
								</td>
								<td class="tablenormal">
									<font class="subTitle"><asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.SelectedPaymentMethods %>" /></font>
								</td>
								<td class="tablenormal" style="width: 196px" align="center">
									<font class="subTitle"><asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.Prioritize %>" /></font>
								</td>
							</tr>
							<tr>
								<td>
									<asp:ListBox ID="ListBoxAvailShippingMethods" runat="server" Height="150px" Width="225px" OnSelectedIndexChanged="ListBoxAvailShippingMethods_SelectedIndexChanged" AutoPostBack="True"></asp:ListBox>
								</td>
								<td>
									<asp:ListBox ID="ListBoxAvailPaymentMethods" runat="server" Height="150px" SelectionMode="Single" Width="225px"></asp:ListBox>
								</td>
								<td valign="middle" align="center" style="width: 53px">
									<asp:Button ID="BtnSelectOne" CssClass="btn btn-default btn-sm" runat="server" Width="36" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.SelectOne %>" OnClick="BtnSelectOne_Click"></asp:Button><br />
									<asp:Button ID="BtnDeSelectOne" runat="server" Width="36" CssClass="btn btn-default btn-sm" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.DeselectOne %>" OnClick="BtnDeSelectOne_Click"></asp:Button><br />
									<asp:Button ID="BtnSelectAll" runat="server" Width="36" CssClass="btn btn-default btn-sm" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.SelectAll %>" OnClick="BtnSelectAll_Click"></asp:Button><br />
									<asp:Button ID="BtnDeSelectALL" runat="server" Width="36" CssClass="btn btn-default btn-sm" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.DeselectAll %>" OnClick="BtnDeSelectALL_Click"></asp:Button></td>
								<td>
									<asp:ListBox ID="ListBoxSelectedPaymentMethods" runat="server" Height="150px" SelectionMode="Multiple" Width="225px"></asp:ListBox>
									<br />
								</td>
								<td style="width: 196px">&nbsp;<asp:Button ID="btnMovePaymentUp" runat="server" CssClass="btn btn-default btn-sm" OnClick="btnMovePaymentUp_Click" Enabled="false" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.MoveUp %>" />
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<div style="padding-top: 15px;">
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.InfoToSave %>" /><br />
			<asp:TextBox ID="txtSaveToDBInfo" runat="server" Width="453px" ReadOnly="true"></asp:TextBox>
		</div>
	</div>
	<div class="list-action-bar">
		<asp:Button ID="btnUpdateShippingToPaymentMethod" runat="server" CssClass="btn btn-primary" OnClick="btnUpdateShippingToPaymentMethod_Click" Text="<%$Tokens:StringResource, admin.MapShippingMethodToPaymentMethod.Update %>" />
	</div>

</asp:Content>