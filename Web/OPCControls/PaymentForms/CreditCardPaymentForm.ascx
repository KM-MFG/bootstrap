<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CreditCardPaymentForm.ascx.cs" Inherits="OPCControls_CreditCardPaymentForm" %>
<%@ Register Src="../../CIM/WalletSelector.ascx" TagName="WalletSelector" TagPrefix="uc1" %>
<asp:UpdatePanel UpdateMode="Conditional" ChildrenAsTriggers="false" ID="UpdatePanelCreditCard" runat="server">
    <ContentTemplate>
        <asp:Panel runat="server" ID="PanelChooseWalletOrNewCard">
            <asp:Panel ID="PanelSelectHeader" runat="server">
                <%# StringResourceProvider.GetString("smartcheckout.aspx.148") %>
            </asp:Panel>
            <asp:Panel ID="PanelSelectWallet" runat="server" CssClass="OPInset">
                <asp:RadioButton GroupName="BillWallet" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.149") %>' ID="RadioButtonWallet" runat="server" OnCheckedChanged="RadioButtonWallet_CheckedChanged" AutoPostBack="true" />
            </asp:Panel>
            <asp:Panel runat="server" ID="PanelWallet" CssClass="walletWrap">
                <uc1:WalletSelector ID="WalletSelector1" runat="server" />
            </asp:Panel>
            <asp:Panel ID="PanelSelectAddNew" runat="server" CssClass="OPInset">
                <asp:RadioButton GroupName="BillWallet" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.150") %>' ID="RadioButtonNewCard" runat="server" OnCheckedChanged="RadioButtonNewCard_CheckedChanged" AutoPostBack="true" />
            </asp:Panel>
        </asp:Panel>
        <asp:Panel ID="PanelCreditDetails" runat="server" DefaultButton="ButtonSaveCreditCardPaymentForm">
            <div id="CCDetailsTable" class="form credit-card-form">
                <div class="form-group">
                    <label>
                        <asp:Label runat="server" ID="LabelCCNameOnCardLabel" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.44") %>' /><span class="opc-required-indicator">*</span>
                    </label>
                    <asp:TextBox runat="server" ID="CCNameOnCard" CssClass="form-control" MaxLength="100" />
                    <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredCCNameOnCard" ControlToValidate="CCNameOnCard"
                        ErrorMessage='<%#StringResourceProvider.GetString("smartcheckout.aspx.45") %>' Display="Dynamic" EnableClientScript="true"
                        ValidationGroup="VGCreditCardPayment" Enabled="true" />
                </div>
                <div class="form-group">
                    <label>
                        <asp:Label runat="server" ID="LabelCCNumber" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.46") %>' /><span class="opc-required-indicator">*</span>
                    </label>
                    <asp:TextBox runat="server" ID="CCNumber"  CssClass="form-control" MaxLength="25" AutoCompleteType="Disabled" autocomplete="off" />
                    <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorCCNumber" ControlToValidate="CCNumber"
                        ErrorMessage='<%#StringResourceProvider.GetString("smartcheckout.aspx.47") %>' Display="Dynamic" EnableClientScript="true"
                        ValidationGroup="VGCreditCardPayment" Enabled="true" />
                    <asp:CustomValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="HFCreditCardTypeValidator" ErrorMessage="" Display="Dynamic" ValidationGroup="VGCreditCardPayment" ControlToValidate="CCNumber" OnServerValidate="HFCreditCardTypeValidator_ServerValidate" />
                </div>
                <div class="form-group">
                    <label>
                        <asp:Label runat="server" ID="LblCardType" Text='<%# this.StringResourceProvider.GetString("smartcheckout.aspx.158") %>' />
                    </label>
                    <asp:PlaceHolder ID="PHCreditCardTypeImages" runat="server">
                        <asp:HiddenField runat="server" ID="HFCreditCardType" />
                        <div class="form-text cc-icons" id="CreditCardIconsWrap">
                            <asp:Image AlternateText="Visa" ImageUrl="~/OPCControls/images/VisaIcon.gif" ID="ImageCardTypeVisa" runat="server" />
                            <asp:Image AlternateText="MasterCard" ImageUrl="~/OPCControls/images/MasterCardIcon.gif" ID="ImageCardTypeMastercard" runat="server" />
                            <asp:Image AlternateText="Amex" ImageUrl="~/OPCControls/images/AmexIcon.gif" ID="ImageCardTypeAmex" runat="server" />
                            <asp:Image AlternateText="Discover" ImageUrl="~/OPCControls/images/DiscoverIcon.gif" ID="ImageCardTypeDiscover" runat="server" />
                            <asp:Image AlternateText="Solo" ImageUrl="~/OPCControls/images/SoloIcon.gif" ID="ImageCardTypeSolo" runat="server" />
                            <asp:Image AlternateText="Maestro" ImageUrl="~/OPCControls/images/MaestroIcon.gif" ID="ImageCardTypeMaestro" runat="server" />
                        </div>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder ID="PHCreditCardTypeDropDown" runat="server">
                        <asp:DropDownList runat="server" CssClass="form-control" ID="DDLCreditCardType">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RFVCreditCardType" ControlToValidate="DDLCreditCardType" ValidationGroup="VGCreditCardPayment"
                            ErrorMessage='<%# this.StringResourceProvider.GetString("smartcheckout.aspx.159") %>' Display="Dynamic" InitialValue="CARD TYPE" />
                    </asp:PlaceHolder>
                </div>
                <div class="form-group month-year">
                    <label>
                        <asp:Label runat="server" ID="LabelCCExpiresLabel" Text='<%# StringResourceProvider.GetString("smartcheckout.aspx.48") %>' /><span class="opc-required-indicator">*</span>
                    </label>
                    <asp:DropDownList runat="server" CssClass="form-control" ID="CCExpiresMonth">
                    </asp:DropDownList>
                    <asp:DropDownList runat="server" CssClass="form-control" ID="CCExpiresYear">
                    </asp:DropDownList>
                </div>
                <div class="form-group security-code" runat="server" id="CCIssueNumberRow">
                    <label>
                        <asp:Label runat="server" ID="LabelCCIssueNumber" Text='<%#StringResourceProvider.GetString("smartcheckout.aspx.49") %>' />
                        <asp:Label CssClass="label-cc-number" runat="server" ID="LabelCCIssueNumberApplicable" Text='<%#StringResourceProvider.GetString("smartcheckout.aspx.50") %>' />
                    </label>
                    <asp:TextBox runat="server" Columns="4" CssClass="form-control" ID="CCIssueNumber" AutoCompleteType="Disabled" autocomplete="off" />
                </div>
                <div class="form-group security-code">
                    <label>
                        <asp:Label runat="server" ID="LabelCCSecurityCode" Text='<%#StringResourceProvider.GetString("smartcheckout.aspx.51") %>' /><span class="opc-required-indicator">*</span>
                    </label>
                    <asp:TextBox runat="server" Columns="4" CssClass="form-control" ID="CCSecurityCode" MaxLength="4" AutoCompleteType="Disabled" autocomplete="off" />
                    <asp:RequiredFieldValidator runat="server" CssClass="opc-error-adjustments error-wrap" ID="RequiredFieldValidatorCCSecurityCode"
                        ControlToValidate="CCSecurityCode" Display="Dynamic" ErrorMessage='<%#StringResourceProvider.GetString("smartcheckout.aspx.52") %>'
                        ValidationGroup="VGCreditCardPayment" />
                </div>
                <div class="form-group" runat="server" id="RowSaveToWallet">
                    <asp:Label runat="server" ID="LabelSaveToWallet" Text='<%#StringResourceProvider.GetString("smartcheckout.aspx.151") %>' />   
                    <asp:CheckBox runat="server" ID="CBSaveToAccount" ValidationGroup="VGCreditCardPayment" TextAlign="Right" />
                </div>
                <div class="form-submit-wrap">
                    <asp:Button ID="ButtonSaveCreditCardPaymentForm" Text='<%#StringResourceProvider.GetString("smartcheckout.aspx.120") %>' runat="server" OnClick="SaveCreditCardPaymentForm_Click" CssClass="button opc-button" />
                </div>
            </div>
        </asp:Panel>
		<asp:Panel ID="PanelError" runat="server" CssClass="row" Visible="false">
			<div class="notice-wrap">
				<asp:Label ID="ErrorMessage" runat="server" />
			</div>
		</asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
