<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BillingAddressNoZipEdit.ascx.cs" Inherits="VortxControls_BillingAddressNoZipEdit" %>
<%@ Register TagPrefix="aspdnsf" Namespace="AspDotNetStorefrontControls.Validators" Assembly="AspDotNetStorefrontControls" %>

<asp:UpdatePanel runat="server" ID="UpdatePanelBillingAddressWrap" RenderMode="Block"
    UpdateMode="Conditional" ChildrenAsTriggers="false">
    <ContentTemplate>
        <div id="BillAddressTable" class="form billing-address-form" runat="server">
            <div class="form-group">
                <label>
                    <asp:Label runat="server" ID="LabelBillFirstName" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.13") %>' /><span class="opc-required-indicator">*</span>
                </label>
                <asp:TextBox runat="server" CssClass="form-control" ID="BillFirstName" MaxLength="49" />
                <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorBillFirstName"
                    ControlToValidate="BillFirstName" ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.FirstNameIsRequired") %>' Display="Dynamic"
                    EnableClientScript="true" ValidationGroup="VGBillingAddress" Enabled="true" />
            </div>
            <div class="form-group">
                <label>
                    <asp:Label runat="server" ID="LabelBillLastName" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.14") %>' /><span class="opc-required-indicator">*</span>
                </label>
                <asp:TextBox runat="server" CssClass="form-control" ID="BillLastName" MaxLength="49" />
                <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorBillLastName"
                    ControlToValidate="BillLastName" ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.LastNameIsRequired") %>' Display="Dynamic"
                    EnableClientScript="true" ValidationGroup="VGBillingAddress" Enabled="true" />
            </div>
            <div class="form-group">
                <label>
                    <asp:Label runat="server" ID="LabelPhone" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.32") %>' /><span class="opc-required-indicator">*</span>
                </label>
				<a runat="server" onclick="adnsf$('.why-phone-info').toggle();" class="why-required-label" title='<%# StringResourceProvider.GetString("smartcheckout.aspx.167") %>'>
					<asp:Literal runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.168") %>' />
				</a>
				<div class="why-phone-info notice-wrap">
					<asp:Literal runat="server" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.167") %>' />
				</div>
                <asp:TextBox runat="server" CssClass="form-control" ID="BillPhone" MaxLength="25" />
                <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorPhone" ControlToValidate="BillPhone"
                    ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.PhoneIsRequired") %>' Display="Dynamic" EnableClientScript="true"
                    ValidationGroup="VGBillingAddress" Enabled="true" />
            </div>
            <div class="form-group">
                <label>
                    <asp:Label runat="server" ID="LabelCompany" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.16") %>' />
                </label>
                <asp:TextBox runat="server" CssClass="form-control" ID="BillCompany" MaxLength="99" />
            </div>
            <div class="form-group">
                <label>
                    <asp:Label runat="server" ID="LabelBillAddress1" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.17") %>' /><span class="opc-required-indicator">*</span>
                </label>

                <asp:TextBox runat="server" CssClass="form-control" ID="BillAddress1" MaxLength="99" />
                <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorBillAddress1"
                    ControlToValidate="BillAddress1" ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.AddressOneIsRequired") %>' Display="Dynamic"
                    EnableClientScript="true" ValidationGroup="VGBillingAddress" Enabled="true" />
            </div>
            <div class="form-group">
                <label>
                    <asp:Label runat="server" ID="LabelBillAddress2" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.19") %>' />
                </label>
                <asp:TextBox runat="server" CssClass="form-control" ID="BillAddress2" MaxLength="99" />

            </div>
            <div class="form-group">
                <label>
                    <asp:Label runat="server" ID="LabelBillOtherCity" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.28") %>' /><span class="opc-required-indicator">*</span>
                </label>
                <asp:TextBox runat="server" CssClass="form-control" ID="BillOtherCity" Visible="true" MaxLength="99" />
                <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorBillOtherCity"
                    ControlToValidate="BillOtherCity" ErrorMessage='<%# StringResourceProvider.GetString("smartcheckout.address.CityIsRequired") %>' Display="Dynamic"
                    EnableClientScript="true" ValidationGroup="VGBillingOtherAddress" Enabled="true" />
            </div>
            <div class="form-group">
                <label>
                    <asp:Label runat="server" ID="LabelBillOtherCountry" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.24") %>' /><span class="opc-required-indicator">*</span>
                </label>
                <asp:DropDownList runat="server" CssClass="form-control" ID="BillOtherCountry" Visible="true" AutoPostBack="true"
                    OnSelectedIndexChanged="BillOtherCountry_OnChanged" OnDataBound="BillOtherCountry_OnDataBound" />
            </div>
            <div class="form-group">
                <label>
                    <asp:Label runat="server" ID="LabelBillOtherState" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.25") %>' /><span class="opc-required-indicator">*</span>
                </label>
                <asp:DropDownList runat="server" CssClass="form-control" ID="BillOtherState" Visible="true" OnDataBound="BillOtherState_OnDataBound" />
            </div>
            <div class="form-group" id="PanelZipCityState" runat="server">
                <label>
                    <asp:Label runat="server" ID="LabelBillZip" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.20") %>' /><span class="opc-required-indicator">*</span>
                </label>

                <asp:TextBox runat="server" CssClass="form-control" ID="BillZip" MaxLength="10" />
                <aspdnsf:ZipCodeValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="ZipCodeValidator" ControlToValidate="BillZip" ValidationGroup="VGBillingOtherAddress"
                    EnableClientScript="true" Display="Dynamic" Text='<%# StringResourceProvider.GetString("smartcheckout.address.ZipCodeIsRequired") %>' />
            </div>
        </div>        
    </ContentTemplate>
</asp:UpdatePanel>