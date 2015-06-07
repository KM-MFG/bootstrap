﻿<%@ Control Language="C#" CodeFile="StringEditor.ascx.cs" Inherits="AspDotNetStorefrontControls.Config.StringEditor" %>

<asp:TextBox runat="server"
	ID="ValueEditor"
	CssClass="form-control app-config-value app-config-value-string"
	Text="<%# Value %>"
	TextMode='<%# Value.Length > MultilineThreshold ? TextBoxMode.MultiLine : TextBoxMode.SingleLine%>'
	Placeholder=<%# Exists 
		? String.Empty 
		: String.Format("(Default) {0}", DefaultValue) %> />
