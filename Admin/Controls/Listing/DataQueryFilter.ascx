<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DataQueryFilter.ascx.cs" Inherits="AspDotNetStorefrontControls.Listing.DataQueryFilter" %>

<asp:SqlDataSource runat="server"
	ID="ValueDataSource"
	ConnectionString="<%$ ConnectionStrings:DBConn %>" />

<div class="form-group">
	<asp:Label runat="server"
		ID="ValueLabel"
		AssociatedControlID="Value" />

	<asp:DropDownList runat="server"
		ID="Value"
		CssClass="form-control"
		DataSourceID="ValueDataSource"
		OnDataBound="Value_DataBound" />
</div>
