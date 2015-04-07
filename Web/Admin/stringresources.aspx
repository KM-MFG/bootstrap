<%@ Page Language="C#" AutoEventWireup="true" CodeFile="stringresources.aspx.cs" Inherits="AspDotNetStorefrontAdmin.stringresourcepage" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<%@ Import Namespace="AspDotNetStorefrontCore" %>

<%@ Register TagPrefix="aspdnsf" Assembly="AspDotNetStorefrontControls" Namespace="AspDotNetStorefrontControls.Listing" %>
<%@ Register TagPrefix="aspdnsf" TagName="StringFilter" Src="Controls/Listing/StringFilter.ascx" %>
<%@ Register TagPrefix="aspdnsf" TagName="BooleanFilter" Src="Controls/Listing/BooleanFilter.ascx" %>
<%@ Register TagPrefix="aspdnsf" TagName="DataQueryFilter" Src="Controls/Listing/DataQueryFilter.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<aspdnsf:AlertMessage ID="AlertMessage" runat="server" />
	<h1><i class="fa fa-pencil-square-o"></i>
		<asp:Literal runat="server" Text="<%$ Tokens:StringResource, admin.stringresources.StringResources %>" />
	</h1>

	<div class="list-action-bar">
		<asp:Panel ID="pnlLocale" Visible="false" runat="server" Style="float: left; margin-right: 5px;">
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.stringresources.Locale %>" AssociatedControlID="ddLocales" />
			<asp:DropDownList ID="ddLocales" runat="server" AutoPostBack="true" />
		</asp:Panel>
		<asp:Button runat="server" ID="btnLoadExcelServer" CssClass="btn btn-default" Text="<%$ Tokens:StringResource, admin.stringresources.ReloadFromExcelOnServer %>" OnClick="btnLoadExcelServer_Click" />
		<asp:Button runat="server" ID="btnUploadExcel" CssClass="btn btn-default" Text="<%$ Tokens:StringResource, admin.stringresources.ReloadFromExcelOnPC %>" OnClick="btnUploadExcel_Click" />
		<asp:Button runat="server" ID="btnShowMissing" CssClass="btn btn-default" Text="<%$ Tokens:StringResource, admin.stringresources.ShowMissing %>" OnClick="btnShowMissing_Click" />
		<asp:Button runat="server" ID="btnClearLocale" CssClass="btn btn-default" Text="<%$ Tokens:StringResource, admin.stringresources.ClearLocale %>" OnClick="btnClearLocale_Click" />
		<asp:HyperLink runat="server" CssClass="btn btn-action" Text="<%$ Tokens:StringResource, admin.stringresources.AddNewString %>" NavigateUrl="stringresource.aspx" />
	</div>

	<aspdnsf:FilteredListing runat="server"
		ID="FilteredListing"
		SortExpression="Name">
		<Filters>
			<aspdnsf:StringFilter runat="server"
				Label="Name"
				FieldName="Name" />
			<aspdnsf:StringFilter runat="server"
				Label="Value"
				FieldName="ConfigValue" />
			<aspdnsf:DataQueryFilter runat="server"
				Label="Locale"
				FieldName="LocaleSetting"
				DataQuery="select Name from LocaleSetting with (NOLOCK) order by DisplayOrder, Description"
				DataValueField="Name"
				QueryStringNames="filterlocale" />
			<aspdnsf:DataQueryFilter runat="server"
				Label="<%$Tokens:StringResource, admin.order.ForStore %>"
				FieldName="StoreId"
				DataQuery="select StoreId, Name from Store"
				DataTextField="Name"
				DataValueField="StoreId" />
			<aspdnsf:BooleanFilter runat="server"
				Label="Modified"
				FieldName="Modified" />
		</Filters>
		<ListingTemplate>
			<div class="white-ui-box">
				<asp:GridView CssClass="table js-sortable-gridview" ID="gMain" runat="server"
					DataSourceID="FilteredListingDataSource"
					PagerSettings-Position="TopAndBottom"
					AutoGenerateColumns="False"
					OnRowCommand="gMain_RowCommand"
					BorderStyle="None"
					BorderWidth="0px"
					CellPadding="0"
					GridLines="None"
					CellSpacing="-1"
					ShowFooter="True"
					DataKeyNames="StringResourceID"
					AllowSorting="true">
					<EmptyDataTemplate>
						<div class="alert alert-info">
							<asp:Literal runat="server" Text="<%$ Tokens:StringResource, admin.common.EmptyDataTemplate.NoResults %>" />
						</div>
					</EmptyDataTemplate>
					<Columns>
						<asp:TemplateField SortExpression="StringResourceID" HeaderText="ID">
							<ItemTemplate>
								<asp:Literal runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StringResourceID") %>' />
							</ItemTemplate>
							<ItemStyle Width="5%" />
						</asp:TemplateField>

						<asp:TemplateField SortExpression="Name" HeaderText="Name">
							<ItemTemplate>
								<asp:HyperLink runat="server" NavigateUrl='<%# Eval("StringResourceID", "stringresource.aspx?stringid={0}")%>'>
									<%# CreateLinkText(DataBinder.Eval(Container.DataItem, "Name")) %>
								</asp:HyperLink>
							</ItemTemplate>
						</asp:TemplateField>

						<asp:TemplateField SortExpression="ConfigValue" HeaderText="Value">
							<ItemTemplate>
								<asp:Literal runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ConfigValue") %>' />
							</ItemTemplate>
						</asp:TemplateField>

						<asp:TemplateField HeaderText="Modified">
							<ItemTemplate>
								<asp:Literal runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Modified").ToString() == "1" ? "Yes" : "No" %>' />
							</ItemTemplate>
						</asp:TemplateField>

						<asp:TemplateField HeaderText="Store Id">
							<ItemTemplate>
								<asp:Literal runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StoreID") %>' />
							</ItemTemplate>
						</asp:TemplateField>

						<asp:TemplateField HeaderText="Locale">
							<ItemTemplate>
								<asp:Literal runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "LocaleSetting") %>' />
							</ItemTemplate>
						</asp:TemplateField>

						<asp:TemplateField HeaderText="Delete">
							<ItemTemplate>
								<asp:LinkButton ID="Delete" ToolTip="Delete" CssClass="delete-link fa-times" CommandName="DeleteItem" CommandArgument='<%# Eval("StringResourceID") %>' runat="Server">
									<asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.common.Delete %>" />
								</asp:LinkButton>
							</ItemTemplate>
							<ItemStyle Width="5%" />
						</asp:TemplateField>

					</Columns>
				</asp:GridView>
			</div>
		</ListingTemplate>
	</aspdnsf:FilteredListing>
</asp:Content>
