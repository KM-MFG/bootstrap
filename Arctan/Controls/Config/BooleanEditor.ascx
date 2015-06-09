<%@ Control Language="C#" CodeFile="BooleanEditor.ascx.cs" Inherits="AspDotNetStorefrontControls.Config.BooleanEditor" %>

<asp:RadioButtonList runat="server"
	ID="ValueEditor"
	CssClass="horizontal-radio-helper"
	RepeatLayout="Flow"
	RepeatDirection="Horizontal">
	<asp:ListItem Text="Yes" Value="true" />
	<asp:ListItem Text="No" Value="false" />
</asp:RadioButtonList>
