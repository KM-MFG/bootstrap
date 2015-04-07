<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SecureNetVaultPanel.ascx.cs" Inherits="AspDotNetStorefront.SecureNetVaultPanel" %>

<script type="text/javascript" src="jscripts/tooltip.js"></script>

<asp:UpdatePanel runat="server"
	UpdateMode="Always"
	ChildrenAsTriggers="true">
	<ContentTemplate>
		<asp:Repeater runat="server"
			ID="CardRepeater"
			OnItemCommand="CardRepeater_ItemCommand">
			<ItemTemplate>
				<div class="page-row">
					<div class="two-thirds">
						<div>
							<strong>
								<asp:Literal runat="server" Text="<%$ Tokens:StringResource,account.creditcardprompt %>" />:
							</strong>
							<asp:Literal runat="server" Text='<%# Eval("CardNumberPadded") %>' />
						</div>
						<div>
							<strong>
								<asp:Literal runat="server" Text="<%$ Tokens:StringResource,account.expires %>" />:
							</strong>
							<asp:Literal runat="server" Text='<%# Eval("ExpDateFormatted") %>' />
						</div>
					</div>
					<div class="one-third">
						<asp:Button runat="server"
							CssClass="button wallet-button"
							CommandName="Delete"
							CommandArgument='<%# Eval("PaymentId") %>'
							Text="<%$ Tokens:StringResource, account.aspx.102 %>" />
					</div>
				</div>
			</ItemTemplate>
		</asp:Repeater>

		<div class="addressfooter">
			<asp:Button runat="server"
				ID="AddNewCardButton"
				CssClass="button wallet-button"
				OnClick="AddNewVaultCard"
				ValidationGroup="none"
				Text="<%$ Tokens:StringResource, account.addcreditcard %>" />

			<asp:Panel runat="server" ID="pnlAddSecureNetCard" Visible="false">
				<span class="error">
					<asp:Literal runat="server" ID="litSNCError" />
				</span>

				<aspdnsf:CreditCardPanel runat="server" 
					ID="SecureNetCreditCardPanel" 
					CreditCardExpDtCaption="<%$ Tokens:StringResource, address.cs.33 %>"
					CreditCardNameCaption="<%$ Tokens:StringResource, address.cs.23 %>" 
					CreditCardNoSpacesCaption="<%$ Tokens:StringResource, shoppingcart.cs.106 %>"
					CreditCardNumberCaption="<%$ Tokens:StringResource, address.cs.25 %>" 
					CreditCardTypeCaption="<%$ Tokens:StringResource, address.cs.31 %>"
					CreditCardVerCdCaption="<%$ Tokens:StringResource, address.cs.28 %>" 
					HeaderCaption="<%$ Tokens:StringResource, checkoutcard.aspx.6 %>"
					WhatIsThis="<%$ Tokens:StringResource, address.cs.50 %>" 
					CCNameReqFieldErrorMessage="<%$ Tokens:StringResource, address.cs.24 %>"
					CreditCardStartDtCaption="<%$ Tokens:StringResource, address.cs.59 %>" 
					CreditCardIssueNumCaption="<%$ Tokens:StringResource, address.cs.61 %>"
					CreditCardIssueNumNote="<%$ Tokens:StringResource, address.cs.63 %>" 
					CCNameValGrp="SecureNetAddCard"
					CCNumberReqFieldErrorMessage="<%$ Tokens:StringResource, address.cs.26 %>" 
					CCNumberValGrp="SecureNetAddCard"
					CCVerCdReqFieldErrorMessage="<%$ Tokens:StringResource, address.cs.29 %>" 
					CCVerCdValGrp="SecureNetAddCard"
					ShowCCVerCd="true"
					ShowCCStartDtFields="false"
					ShowCCVerCdReqVal="<%$ Tokens:AppConfigBool, CardExtraCodeIsOptional %>" 
					ShowValidatorsInline="true" 
					ShowCimSaveCard="false" />

				<asp:Button runat="server" 
					ID="btnSecureNetSaveCard" 
					CssClass="button update-account-button" 
					OnClick="btnSecureNetSaveCard_Click" 
					ValidationGroup="SecureNetAddCard" 
					Text="Save Credit Card" />

			</asp:Panel>
		</div>
	</ContentTemplate>

</asp:UpdatePanel>
