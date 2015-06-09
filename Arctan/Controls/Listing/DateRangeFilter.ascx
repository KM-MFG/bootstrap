<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DateRangeFilter.ascx.cs" Inherits="AspDotNetStorefrontControls.Listing.DateRangeFilter" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div class="row">
	<div class="col-md-6">
		<div class="form-group">
			<asp:Label runat="server" ID="StartValueLabel" AssociatedControlID="StartValue" /><br />
			<telerik:RadDatePicker ID="StartValue" runat="server" MaxDate="9999-12-31" MinDate="0001-01-01" Width="100%">
				<Calendar runat="server" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
			</telerik:RadDatePicker>
		</div>
	</div>

	<div class="col-md-6">
		<div class="form-group">
			<asp:Label runat="server" ID="EndValueLabel" AssociatedControlID="EndValue" /><br />
			<telerik:RadDatePicker ID="EndValue" runat="server" MaxDate="9999-12-31" MinDate="0001-01-01" Width="100%">
				<Calendar runat="server" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x" />
			</telerik:RadDatePicker>
		</div>
	</div>
</div>
