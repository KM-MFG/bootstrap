<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ManualSearch.ascx.cs" Inherits="AspDotNetStorefrontControls.ManualSearch" %>
<div class="help-menu-wrap">
	<div id="help-menu">
		<div class="header-help-wrap">
			<asp:Panel runat="server" CssClass="input-group" DefaultButton="lbtManualSearch">
				<asp:TextBox runat="server" ClientIDMode="Static" ID="txtManualSearch" class="form-control js-help-box" placeholder="Search Help" />
				<span class="input-group-btn">
					<asp:LinkButton runat="server" ID="lbtManualSearch" class="btn btn-default" OnClick="search_OnClick">
						GO
					</asp:LinkButton>
				</span>
			</asp:Panel>
		</div>
	</div>
</div>
