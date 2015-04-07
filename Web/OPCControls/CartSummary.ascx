<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CartSummary.ascx.cs" Inherits="OPCControls_CartSummary" %>
<asp:UpdatePanel ID="UpdatePanelCartSummary" runat="server" UpdateMode="Conditional"
    RenderMode="Block" ChildrenAsTriggers="false">
    <ContentTemplate>
        <div class="opc-subtotals-wrap sub-total">
			<table class="table">
				<tr>
					<td>
						<asp:Label runat="server" ID="LabelSubTotal" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.60") %>' />
					</td>
					<td class="text-right">
						<asp:Label runat="server" ID="SubTotal" />
					</td>
				</tr>
				<tr id="LineItemDiscountRow" runat="server" >
					<td>
						<asp:Label ID="LineItemDiscountLabel" runat="server" />
					</td>
					<td class="text-right">
						<asp:Label ID="LineItemDiscount" runat="server" />
					</td>
				</tr>
				<tr id="QuantityDiscountRow" runat="server" >
					<td>
						<asp:Label runat="server" ID="LabelQuantityDiscount" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.62") %>' />
					</td>
					<td class="text-right">
						<asp:Label runat="server" ID="LabelQuantityDiscountAmount" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label runat="server" ID="LabelShipMethodAmounts" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.63") %>' />
					</td>
					<td class="text-right">
						<asp:Label runat="server" ID="ShipMethodAmount" />
					</td>
				</tr>
				<tr id="trTaxAmounts" runat="server" >
					<td>
						<asp:Label runat="server" ID="LabelTaxAmounts" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.64") %>' />
					</td>
					<td class="text-right">
						<asp:Label runat="server" ID="TaxAmount" />
					</td>
				</tr>
				<tr id="OrderItemDiscountRow" runat="server" >
					<td>
						<asp:Label ID="OrderItemDiscountLabel" runat="server" />
					</td>
					<td class="text-right">
						<asp:Label ID="OrderItemDiscount" runat="server" />
					</td>
				</tr>
				<tr id="GiftCardRow" runat="server" >
					<td>
						<asp:Label ID="GiftCardLabel" runat="server" Text='<%# StringResourceProvider.GetString("order.cs.83") %>' />
					</td>
					<td class="text-right">
						<asp:Label ID="GiftCardAmount" runat="server" />
					</td>
				</tr>
				<tr id="Tr2" runat="server" >
					<td>
						<asp:Label runat="server" ID="LabelTotal" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.65") %>' />
					</td>
					<td class="text-right">
						<asp:Label runat="server" ID="Total" />
					</td>
				</tr>
			</table>

        </div>
    </ContentTemplate>
</asp:UpdatePanel>
