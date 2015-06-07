<%@ Page Language="c#" Inherits="AspDotNetStorefrontAdmin.ShippingMethod" CodeFile="shippingmethod.aspx.cs" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<%@ Register Src="Controls/LocaleField.ascx" TagPrefix="aspdnsf" TagName="LocaleField" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<aspdnsf:ReturnUrlTracker runat="server" ID="ReturnUrlTracker" DefaultReturnUrl="shipping.aspx" Blacklist="ShippingMethodStates.aspx,ShippingMethodCountries.aspx,ShippingMethodZones.aspx" />
	<h1>
		<i class="fa fa-anchor"></i>
		Edit Shipping Method
	</h1>
	<aspdnsf:AlertMessage runat="server" ID="AlertMessage" />
	<asp:Panel runat="server" DefaultButton="SubmitButton">
		<div class="item-action-bar">
			<asp:PlaceHolder runat="server" ID="plcNavButtonsTop">
				<a class="btn btn-default" href='<%= String.Format("shippingmethodstates.aspx?shippingmethodid={0}", ShippingMethodID.ToString()) %>'>Set Allowed States</a>
				<a class="btn btn-default" href='<%= String.Format("shippingmethodcountries.aspx?shippingmethodid={0}", ShippingMethodID.ToString()) %>'>Set Allowed Countries</a>
				<a class="btn btn-default" href='<%= String.Format("shippingmethodzones.aspx?shippingmethodid={0}", ShippingMethodID.ToString())%>'>Set Allowed Zones</a>
			</asp:PlaceHolder>
			<asp:Button runat="server" ID="btnDeleteTop" CssClass="btn btn-danger" Text="<%$Tokens:StringResource, admin.common.delete %>" OnClick="Delete_Click" />
			<asp:HyperLink runat="server" ID="btnCloseTop" CssClass="btn btn-default" NavigateUrl="<%# ReturnUrlTracker.GetHyperlinkReturnUrl() %>" Text="<%$Tokens:StringResource, admin.common.close %>" />			
			<asp:Button ID="btnSaveAndCloseTop" runat="server" CssClass="btn btn-default" OnClick="btnSaveAndClose_Click" ValidationGroup="SMSubmit" Text="<%$Tokens:StringResource, admin.common.saveandclose %>" />
			<asp:Button runat="server" ID="SubmitButton" CssClass="btn btn-primary" Text="<%$Tokens:StringResource, admin.common.save %>" OnClick="SubmitButton_Click" ValidationGroup="SMSubmit" />
		</div>
		<div class="white-ui-box">
			<div class="form-group">
				<div class="row">
					<div class="col-sm-3">
						<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.common.Name %>" />
					</div>
					<div class="col-sm-5">
						<aspdnsf:LocaleField runat="server" Enabled='<%#(bool)(!IsRealTime) %>' ID="NameLocaleField" DefaultLocaleSetting="<%#ThisCustomer.LocaleSetting %>" ValidationGroup="SMSubmit" />
					</div>
				</div>
			</div>
			<div class="form-group" id="DisplayNameRow" runat="server">
				<div class="row">
					<div class="col-sm-3">
						<asp:Label runat="server" Text="Display Name" />
					</div>
					<div class="col-sm-5">
						<aspdnsf:LocaleField runat="server" ID="DisplayNameLocaleField" RequiredValidation="false"  DefaultLocaleSetting="<%#ThisCustomer.LocaleSetting %>" ValidationGroup="SMSubmit" />
					</div>
				</div>
			</div>
			<asp:Panel runat="server" ID="StoreMappingPanel" Visible="false">
				<div class="row">
					<div class="col-sm-3">
						<asp:Label runat="server" AssociatedControlID="MappedStores" Text="<%$Tokens:StringResource, admin.editshippingmethod.MappedStores %>" />
					</div>
					<div class="col-sm-9">
						<asp:CheckBoxList runat="server" ID="MappedStores" />
					</div>
				</div>
			</asp:Panel>
			<asp:Panel runat="server" ID="ShipRushPanel" CssClass="form-group" Visible="false">
				<div class="row">
					<div class="col-sm-3">
						<asp:Label runat="server" ID="ShipRushTemplateLabel" AssociatedControlID="ShipRushTemplate" Text="<%$Tokens:StringResource, admin.editshippingmethod.ShipRushTemplate %>"></asp:Label>
					</div>
					<div class="col-sm-9">
						<asp:TextBox runat="server" ID="ShipRushTemplate" CssClass="text-lg" />
						<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.editshippingmethod.Sample %>" />
					</div>
				</div>
			</asp:Panel>
		</div>
		<div class="item-action-bar">
			<asp:PlaceHolder runat="server" ID="plcNavButtons">
				<a class="btn btn-default" href='<%= String.Format("shippingmethodstates.aspx?shippingmethodid={0}", ShippingMethodID.ToString()) %>'>Set Allowed States</a>
				<a class="btn btn-default" href='<%= String.Format("shippingmethodcountries.aspx?shippingmethodid={0}", ShippingMethodID.ToString()) %>'>Set Allowed Countries</a>
				<a class="btn btn-default" href='<%= String.Format("shippingmethodzones.aspx?shippingmethodid={0}", ShippingMethodID.ToString())%>'>Set Allowed Zones</a>
			</asp:PlaceHolder>
			<asp:Button runat="server" ID="btnDelete" CssClass="btn btn-danger" Text="<%$Tokens:StringResource, admin.common.delete %>" OnClick="Delete_Click" />
			<asp:HyperLink runat="server" ID="btnClose" CssClass="btn btn-default" NavigateUrl="<%# ReturnUrlTracker.GetHyperlinkReturnUrl() %>" Text="<%$Tokens:StringResource, admin.common.close %>" />			
			<asp:Button ID="btnSaveAndClose" runat="server" CssClass="btn btn-default" OnClick="btnSaveAndClose_Click" ValidationGroup="SMSubmit" Text="<%$Tokens:StringResource, admin.common.saveandclose %>" />
			<asp:Button runat="server" CssClass="btn btn-primary" Text="<%$Tokens:StringResource, admin.common.save %>" OnClick="SubmitButton_Click" ValidationGroup="SMSubmit" />
		</div>
	</asp:Panel>
</asp:Content>