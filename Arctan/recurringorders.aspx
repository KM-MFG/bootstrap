<%@ Page Language="c#" Inherits="AspDotNetStorefrontAdmin.recurringorders" CodeFile="recurringorders.aspx.cs" MaintainScrollPositionOnPostback="true" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<%@ Register TagPrefix="aspdnsf" Assembly="AspDotNetStorefrontControls" Namespace="AspDotNetStorefrontControls.Listing" %>
<%@ Register TagPrefix="aspdnsf" TagName="StringFilter" Src="Controls/Listing/StringFilter.ascx" %>
<%@ Register TagPrefix="aspdnsf" TagName="DateRangeFilter" Src="Controls/Listing/DateRangeFilter.ascx" %>
<%@ Register TagPrefix="aspdnsf" TagName="DataQueryFilter" Src="Controls/Listing/DataQueryFilter.ascx" %>
<%@ Register TagPrefix="aspdnsf" TagName="IntegerFilter" Src="Controls/Listing/IntegerFilter.ascx" %>
<%@ Register Src="Controls/LinkGroupRecurring.ascx" TagPrefix="aspdnsf" TagName="LinkGroupRecurring" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<h1><i class="fa fa-list"></i>
		Recurring Orders</h1>

	<aspdnsf:AlertMessage ID="AlertMessage" runat="server" />

	<div class="list-action-bar">
		<aspdnsf:LinkGroupRecurring runat="server" ID="LinkGroupRecurring" SelectedLink="recurringorders.aspx" />
		<asp:Button runat="server" ID="btnProcessAll" Enabled="false" CssClass="btn btn-primary" Text="<%$Tokens:StringResource, admin.recurring.ProcessChargesAll %>" OnClick="btnProcessAll_Click" />
	</div>

	<aspdnsf:FilteredListing runat="server"
		ID="FilteredListing"
		SortExpression="OriginalRecurringOrderNumber">
		<Filters>
			<aspdnsf:IntegerFilter runat="server" Label="Order Number" FieldName="ShoppingCart.OriginalRecurringOrderNumber" />
			<aspdnsf:StringFilter runat="server" Label="Customer ID" FieldName="ShoppingCart.CustomerID" />
			<aspdnsf:StringFilter runat="server" Label="Email" FieldName="Customer.Email" />
			<aspdnsf:DateRangeFilter runat="server"
				StartLabel="Next Ship Date Start"
				EndLabel="Next Ship Date End"
				FieldName="NextRecurringShipDate" />
			<aspdnsf:DataQueryFilter runat="server"
				Label="<%$Tokens:StringResource, admin.order.ForStore %>"
				FieldName="Store.StoreId"
				DataQuery="select StoreId, Name from Store"
				DataTextField="Name"
				DataValueField="StoreId" />
		</Filters>
		<ListingTemplate>
			<div class="white-ui-box">
				<asp:GridView CssClass="table table-detail" ID="gMain" runat="server"
					DataSourceID="FilteredListingDataSource"
					PagerSettings-Position="TopAndBottom"
					AutoGenerateColumns="False"
					AllowSorting="true"
					BorderStyle="None"
					BorderWidth="0px"
					CellPadding="0"
					GridLines="None"
					CellSpacing="-1"
					ShowFooter="True">
					<EmptyDataTemplate>
						<div class="alert alert-info">
							<asp:Literal runat="server" Text="<%$ Tokens:StringResource, admin.common.EmptyDataTemplate.NoResults %>" />
						</div>
					</EmptyDataTemplate>
					<Columns>
						<asp:HyperLinkField
							HeaderText="Order Number"
							DataNavigateUrlFields="OriginalRecurringOrderNumber"
							DataNavigateUrlFormatString="recurringorder.aspx?originalorderid={0}"
							DataTextField="OriginalRecurringOrderNumber"
							SortExpression="OriginalRecurringOrderNumber"/>

						<asp:BoundField HeaderText="Customer ID" DataField="CustomerID" SortExpression="CustomerId" />

						<asp:BoundField HeaderText="Email" DataField="Email" SortExpression="Email" />

						<asp:BoundField HeaderText="Next Shipping Date" DataField="NextRecurringShipDate" SortExpression="NextRecurringShipDate" />

						<asp:BoundField HeaderText="Store" DataField="Name" />
					</Columns>
				</asp:GridView>
			</div>
		</ListingTemplate>
	</aspdnsf:FilteredListing>

	<asp:Literal ID="ltContent" runat="server" />
</asp:Content>


