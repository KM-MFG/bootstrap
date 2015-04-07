<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MiniCartControl.ascx.cs"
    Inherits="MiniCartControl" %>
<%@ Import Namespace="Vortx.OnePageCheckout.Models" %>
<asp:UpdatePanel ID="UpdatePanelMiniCartControl" runat="server" UpdateMode="Conditional"
    ChildrenAsTriggers="false">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="RepeaterCartItems" />
    </Triggers>
    <ContentTemplate>
        <asp:Repeater ID="RepeaterCartItems" runat="server" Visible="true" OnItemCommand="RepeaterCartItems_OnItemCommand"
            OnItemDataBound="RepeaterCartItems_OnItemDataBound">
            <ItemTemplate>
                <div class="mini-cart-item-row">
                    <div class="cart-item-image-wrap">
                        <asp:Image runat="server" ID="ProductImage" />
                    </div>
                    <div class="cart-item-name">
                        <asp:HyperLink runat="server" ID="ItemLink" NavigateUrl='<%# ((IShoppingCartItem) Container.DataItem).ProductUrl %>'>
                            <asp:Label ID="ItemName" runat="server" Text='<%# ((IShoppingCartItem) Container.DataItem).Name %>' />
                        </asp:HyperLink>
                    </div>
                    <div class="cart-item-number">
                        <asp:Literal ID="LitItemNumber" runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.97") %>' />
                        <asp:Label ID="LabelSKU" runat="server" Text='<%# ((IShoppingCartItem) Container.DataItem).Sku %>' />
                    </div>
                    <div class="clear"></div>
                    <div class="cart-item-details">
                        <div class="page-row">
                            <asp:Panel ID="PanelSize" runat="server" Visible="false">
                                <asp:Label ID="ProductSizeLabel" runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.95") %>'></asp:Label><asp:Label ID="ProductSize" runat="server" Text='<%# ((Vortx.OnePageCheckout.Models.IShoppingCartItem)Container.DataItem).Size%>'></asp:Label>
                            </asp:Panel>
                            <asp:Panel ID="PanelColor" runat="server" Visible="false">
                                <asp:Label ID="ProductColorLabel" runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.96") %>'></asp:Label><asp:Label ID="ProductColor" runat="server" Text='<%# ((Vortx.OnePageCheckout.Models.IShoppingCartItem)Container.DataItem).Color%>'></asp:Label>
                            </asp:Panel>
                            <div class="cartItemPrice">
                                <asp:Label ID="CartItemPriceLabel" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.94") %>' runat="server" />
                                <asp:Label ID="CartItemPriceValue" Text='<%# ((IShoppingCartItem) Container.DataItem).Price.ToString("C") %>'
                                    runat="server" />
                                <asp:Label ID="CartItemPriceVat" Text='<%# StringResourceProvider.GetString("setvatsetting.aspx.6") %>' runat="server" />
                            </div>
                        </div>
                        <table>
							<tr>
								<td>
									<asp:Label ID="CartItemQuantityLabel" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.98") %>' runat="server" />
								</td>
								<td></td>
							</tr>
							<tr>
								<td>
									<asp:DropDownList ID="CartItemRestrictedQuantity" runat="server" Visible="false"></asp:DropDownList>
									<asp:TextBox ID="CartItemQuantityValue" CssClass="form-control quantity-box" runat="server"
										Text='<%# ((IShoppingCartItem) Container.DataItem).Quantity %>' />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="CartItemQuantityValue"
										ErrorMessage='<%# StringResourceProvider.GetString("common.cs.80") %>' ValidationExpression="^\d+$" ValidationGroup="val" Display="Dynamic"></asp:RegularExpressionValidator>
								</td>
								<td class="text-right">
									<asp:Button runat="server" ID="ButtonCartItemUpdate" CssClass="button opc-button opc-update-button" ValidationGroup="val"
										Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.112") %>' CommandName="Update" CommandArgument='<%# ((IShoppingCartItem) Container.DataItem).ItemCartId %>' />
									<asp:Button runat="server" ID="ButtonCartItemRemove" CssClass="button opc-button opc-remove-button"
										Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.113") %>' CommandName="Remove" CommandArgument='<%# ((IShoppingCartItem) Container.DataItem).ItemCartId %>' />
								</td>
							</tr>
						</table>
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
		<table class="table">
			<asp:Repeater ID="RepeaterOrderOptions" runat="server" OnItemCommand="RepeaterOrderOptions_OnItemCommand">
				<HeaderTemplate>
					<tr>
						<th>
							<span class="OrderOptionsTitle">
								<asp:Literal runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.99") %>' />
							</span>
						</th>
						<th>
							<span class="OrderOptionsRowHeader">
								<asp:Literal runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.100") %>' /></span>
						</th>
						<th>
							<span class="OrderOptionsRowHeader">
								<asp:Literal runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.101") %>' /></span>
						</th>
					</tr>
				</HeaderTemplate>
				<ItemTemplate>
					<tr>
						<td>
							<img src="images/OrderOption/icon/<%# ((IOrderOptionItem)Container.DataItem).OrderOptionID %>.jpg"
								class="order-options-image" border="0">
							<span class="OrderOptionsName"><%# ((IOrderOptionItem)Container.DataItem).Name %></span>
						</td>
						<td>
							<span class="OrderOptionsPrice">
								<%# ((IOrderOptionItem)Container.DataItem).Cost.ToString("C") %></span>
						</td>
						<td>
							<asp:Image ID="OrderOptionSelectedImage" runat="server" ImageUrl="images/Selected.gif" />
						</td>
					</tr>
				</ItemTemplate>
			</asp:Repeater>
		</table>
	</ContentTemplate>
</asp:UpdatePanel>
