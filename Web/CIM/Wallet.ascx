<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Wallet.ascx.cs" Inherits="CIM_Wallet" %>

<%@ Register TagPrefix="cim" TagName="CreditCardEditor" Src="CreditCardEditor.ascx" %>

<div id="walletHeaderDescription">
	<span id="walletHeaderDescriptionText"></span>
</div>

<asp:UpdatePanel runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
	<ContentTemplate>
		<asp:Repeater runat="server"
			ID="CardRepeater"
			OnItemCommand="CardRepeater_ItemCommand">
			<ItemTemplate>
				<div class="page-row">
					<div class="one-third">
						<asp:Image runat="server"
							ID="ImageCard"
							CssClass="wallet-card-image"
							ImageUrl='<%# GatewayAuthorizeNet.DisplayTools.GetCardImage("~/App_Themes/Skin_1/images/", ((GatewayAuthorizeNet.PaymentProfileWrapper)Container.DataItem).CardType) %>' />
					</div>
					<div class="one-third">
						<div class="wallet-card-type">
							<asp:Label runat="server" Text='<%#((GatewayAuthorizeNet.PaymentProfileWrapper)Container.DataItem).CardType %>' />
						</div>
						<div class="wallet-card-number">
							<asp:Label runat="server" Text='<%#((GatewayAuthorizeNet.PaymentProfileWrapper)Container.DataItem).CreditCardNumberMasked  %>' />
						</div>
						<div class="wallet-exp-date">
							Exp.
							<asp:Label runat="server" Text='<%#((GatewayAuthorizeNet.PaymentProfileWrapper)Container.DataItem).ExpirationMonth  %>' />
							/
							<asp:Label runat="server" Text='<%#((GatewayAuthorizeNet.PaymentProfileWrapper)Container.DataItem).ExpirationYear %>' />
						</div>
					</div>
					<div class="one-third">
						<div class="wallet-remove-button-wrap">
							<asp:Button runat="server"
								ID="ButtonRemoveCard"
								CssClass="button wallet-button"
								CommandName="Delete"
								CommandArgument='<%#((GatewayAuthorizeNet.PaymentProfileWrapper)Container.DataItem).ProfileId %>'
								Text="<%$ Tokens:StringResource, account.aspx.102%>" />
						</div>
						<div class="wallet-edit-button-wrap">
							<asp:Button runat="server"
								ID="ButtonEditCard"
								CssClass="button wallet-button"
								CommandName="Edit"
								CommandArgument='<%#((GatewayAuthorizeNet.PaymentProfileWrapper)Container.DataItem).ProfileId %>'
								Text="<%$ Tokens:StringResource, account.aspx.103%>" />
						</div>
					</div>
				</div>
			</ItemTemplate>
		</asp:Repeater>

		<div id="walletAddPaymentWrap">
			<asp:Button runat="server"
				ID="ButtonAddPaymentType"
				CssClass="button wallet-button"
				OnClick="ButtonAddPaymentType_Click"
				Text="<%$ Tokens:StringResource, account.aspx.104%>" />

			<asp:Panel runat="server" ID="PanelAddPaymentType">
				<cim:CreditCardEditor runat="server" ID="CreditCardEditor" />
			</asp:Panel>
		</div>
	</ContentTemplate>
</asp:UpdatePanel>
