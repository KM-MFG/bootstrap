﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CreditCardEditor.ascx.cs"
    Inherits="CIM_CreditCardEditor" %>
<div class="page-row form cim-form">
    <div class="one-third">
        <div class="form-group">
            <div>
                <label>
                    <asp:Label Text="<%$ Tokens:StringResource, account.aspx.93%>" runat="server" ID="LabelCreditCard" ValidationGroup="CIMCCEditor" />
                </label>
            </div>
            <asp:TextBox ID="TextCreditCard" CssClass="form-control" runat="server" />
            <asp:RequiredFieldValidator ValidationGroup="CIMCCEditor" ID="RFCreditCardNumber"
                runat="server" ControlToValidate="TextCreditCard" Text="*" Display="Dynamic"
                EnableClientScript="false" />
        </div>
        <div class="form-group">
            <div>
                <label>
                    <asp:Label Text="<%$ Tokens:StringResource, account.aspx.94%>" runat="server" ID="LabelExpDate" />
                </label>
            </div>

            <asp:DropDownList CssClass="form-control-inline" ValidationGroup="CIMCCEditor" ID="ExpirationMonth" runat="server">
                <asp:ListItem Text="<%$ Tokens:StringResource, account.aspx.95%>" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ValidationGroup="CIMCCEditor" ID="RFMonth" runat="server"
                ControlToValidate="ExpirationMonth" InitialValue="--" Text="*" Display="Dynamic"
                EnableClientScript="false" />
            /
            <asp:DropDownList CssClass="form-control-inline" ID="ExpirationYear" runat="server" />
            <asp:RequiredFieldValidator ValidationGroup="CIMCCEditor" ID="RFYear" runat="server"
                ControlToValidate="ExpirationYear" InitialValue="--" Text="*" Display="Dynamic"
                EnableClientScript="false" />
        </div>
        <div class="form-group">
            <div>
                <label>
                    <asp:Label Text="<%$ Tokens:StringResource, account.aspx.96%>" runat="server" ID="LabelCardSecurityCode" />
                </label>
            </div>
            <asp:TextBox CssClass="form-control-inline" ID="TextCardSecurity" ValidationGroup="CIMCCEditor" runat="server" />
            <asp:RequiredFieldValidator ValidationGroup="CIMCCEditor" ID="RFCCSecurity" runat="server"
                ControlToValidate="TextCardSecurity" Text="*" Display="Dynamic" EnableClientScript="false" />
            <div>
                <a id="aCardCodeToolTip" href="javascript:void(0);">
                    <asp:Literal runat="server" Text="<%$ Tokens:StringResource, address.cs.50%>" />
                </a>
            </div>
        </div>
        <div class="form-group">
            <div>
                <label>
                    <asp:Label Text="<%$ Tokens:StringResource, account.aspx.97%>" runat="server" ID="LabelBillingAddress" />
                </label>
            </div>
            <asp:DropDownList CssClass="form-control" ID="BillingAddresses" runat="server" ValidationGroup="CIMCCEditor"
                AppendDataBoundItems="true">
                <asp:ListItem Text="<%$ Tokens:StringResource, account.aspx.98%>" Value="--" />
            </asp:DropDownList>
        </div>
        <div style="display: none">
            <asp:CheckBox runat="server" ValidationGroup="CIMCCEditor" ID="CBMakePrimaryCard"
                Text="<%$ Tokens:StringResource, account.aspx.99%>" />
        </div>
        <div class="form-submit-wrap">
            <asp:Button runat="server" ValidationGroup="CIMCCEditor" ID="ButtonSave" Text="<%$ Tokens:StringResource, account.aspx.100%>"
                OnClick="ButtonSave_Click" UseSubmitBehavior="false" CssClass="button call-to-action wallet-button" />
            <asp:Button runat="server" CausesValidation="false" ID="ButtonCancel" Text="<%$ Tokens:StringResource, account.aspx.101%>"
                OnClick="ButtonCancel_Click" CssClass="button cancel-button" />
        </div>
    </div>
</div>
<asp:Panel ID="PanelError" runat="server">
    <asp:Label ID="ErrorMessage" runat="server" />
</asp:Panel>
