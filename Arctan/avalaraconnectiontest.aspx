<%@ Page Language="C#" AutoEventWireup="true" CodeFile="avalaraconnectiontest.aspx.cs" Inherits="Admin_AvalaraConnectionTest" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<aspdnsf:ReturnUrlTracker runat="server" ID="ReturnUrlTracker" DefaultReturnUrl="AppConfigs.aspx" />

	<div class="item-action-bar">
		<asp:HyperLink runat="server"
			CssClass="btn btn-default"
			NavigateUrl="<%# ReturnUrlTracker.GetHyperlinkReturnUrl() %>"
			Text="Back to AppConfigs" />
	</div>

	<aspdnsf:AlertMessage runat="server" ID="ctlAlertMessage" />
</asp:Content>