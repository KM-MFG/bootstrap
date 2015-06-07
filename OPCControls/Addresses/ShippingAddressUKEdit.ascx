<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShippingAddressUKEdit.ascx.cs"
    Inherits="VortxControls_ShippingAddressUKEdit" %>
<asp:UpdatePanel runat="server" ID="UpdatePanelShippingAddressWrap" RenderMode="Block"
    UpdateMode="Conditional" ChildrenAsTriggers="false">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="ButtonSaveAddress" />
    </Triggers>
    <ContentTemplate>
        <div id="ShipAddressTable" class="form shipping-address-form" runat="server">
            <div class="page-row">
                <label>
                    <asp:Label runat="server" ID="LabelShipFirstName" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.13") %>' /><span class="opc-required-indicator">*</span>
                </label>
                <asp:TextBox runat="server" CssClass="form-control" ID="ShipFirstName" />
                <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorShipFirstName"
                    ControlToValidate="ShipFirstName" ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.FirstNameIsRequired") %>' Display="Dynamic"
                    EnableClientScript="true" ValidationGroup="VGShippingAddress" Enabled="true" />
            </div>
            <div class="page-row">
                <label>
                    <asp:Label runat="server" ID="LabelShipLastName" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.14") %>' /><span class="opc-required-indicator">*</span>
                </label>
                <asp:TextBox runat="server" CssClass="form-control" ID="ShipLastName" />
                <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorShipLastName"
                    ControlToValidate="ShipLastName" ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.LastNameIsRequired") %>' Display="Dynamic"
                    EnableClientScript="true" ValidationGroup="VGShippingAddress" Enabled="true" />
            </div>
            <div class="page-row">
                <label>
                    <asp:Label ID="LabelPhone" runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.32") %>' /><span class="opc-required-indicator">*</span>
                </label>
				<a runat="server" onclick="adnsf$('.why-phone-info').toggle();" class="why-required-label" title='<%# StringResourceProvider.GetString("smartcheckout.aspx.167") %>'>
					<asp:Literal runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.168") %>' />
				</a>
				<div class="why-phone-info notice-wrap">
					<asp:Literal runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.167") %>' />
				</div>
                <asp:TextBox ID="ShipPhone" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorPhone" CssClass="opc-error-adjustments error-wrap" runat="server"
                    ControlToValidate="ShipPhone" Display="Dynamic" EnableClientScript="true"
                    Enabled="true" ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.PhoneIsRequired") %>'
                    ValidationGroup="VGShippingAddress" />
            </div>
            <div class="page-row">
                <label>
                    <asp:Label ID="LabelShipAddress1" runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.17") %>' /><span class="opc-required-indicator">*</span>
                </label>
                <asp:TextBox ID="ShipAddress1" CssClass="form-control" runat="server" />
                <asp:RequiredFieldValidator CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorShipAddress1"
                    runat="server" ControlToValidate="ShipAddress1" Display="Dynamic"
                    EnableClientScript="true" Enabled="true"
                    ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.AddressOneIsRequired") %>'
                    ValidationGroup="VGShippingAddress" />
            </div>
            <div class="page-row">
                <label>
                    <asp:Label ID="LabelShipAddress2" runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.19") %>' />
                </label>
                <asp:TextBox ID="ShipAddress2" CssClass="form-control" runat="server" />
            </div>
            <div class="page-row" id="PanelZipCityState" runat="server">
                <label>
                    <asp:Label runat="server" ID="LabelShipZip" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.29") %>' /><span class="opc-required-indicator">*</span>
                </label>
                <asp:TextBox runat="server" CssClass="form-control" ID="ShipZip" />
                <asp:RequiredFieldValidator CssClass="opc-error-adjustments error-wrap" runat="server" ID="RequiredEmailAddress" ControlToValidate="ShipZip"
                    ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.ZipCodeIsRequired") %>' Display="Dynamic" EnableClientScript="true"
                    ValidationGroup="VGShippingAddress" Enabled="true" />
            </div>
            <div class="page-row">
                <label>
                    <asp:Label ID="LabelShipCity" runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.28") %>' />
                </label>
                <asp:TextBox ID="ShipCity" CssClass="form-control" runat="server" />
            </div>
            <div class="page-row">
                <label>
                    <asp:Label ID="LabelShipCounty" runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.31") %>' />
                </label>
                <asp:TextBox ID="ShipCounty" CssClass="form-control" runat="server" />
            </div>
            <div class="page-row" runat="server" id="PanelShipComments">
                <label>
                    <asp:Label ID="LabelShipComments" runat="server"
                        Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.37") %>' />
                </label>
                <asp:TextBox ID="ShipComments" CssClass="form-control" runat="server" Rows="2" TextMode="MultiLine" />

                <div class="form-text">
                    <asp:Literal runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.38") %>' />
                </div>
            </div>
        </div>
        <div class="next-step-wrap">
            <asp:Button ID="ButtonSaveAddress" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.119") %>' runat="server" OnClick="SaveAddress_Click"
                CssClass="button opc-button" />
            <div class="clear">
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
