<%@ Page Language="c#" AutoEventWireup="true" Inherits="AspDotNetStorefrontAdmin.securitylog" CodeFile="securitylog.aspx.cs" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<h1>
		<i class="fa fa-lock"></i>
		365 Day Security Log
	</h1>
	<aspdnsf:AlertMessage runat="server" ID="AlertMessage" />
	<div class="white-ui-box">
		<asp:GridView ID="GridView1" runat="server"
			AllowPaging="True"
			CssClass="table"
			PageSize="100"
			Width="100%"
			GridLines="None"
			CellPadding="0"
			ShowFooter="True"
			OnRowDataBound="GridView1_RowDataBound1"
			OnPageIndexChanging="GridView1_PageIndexChanging">
			<FooterStyle CssClass="gridFooter" />
			<RowStyle CssClass="table-row2" />
			<PagerStyle CssClass="gridPager" HorizontalAlign="Left" />
			<HeaderStyle CssClass="gridHeader" />
			<AlternatingRowStyle CssClass="table-alternatingrow2" />
		</asp:GridView>
	</div>
</asp:Content>