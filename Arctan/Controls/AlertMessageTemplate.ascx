<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AlertMessageTemplate.ascx.cs" Inherits="AspDotNetStorefrontControls.AlertMessageTemplate" %>

<button type='button' class='close' data-dismiss='alert'>
	<span aria-hidden='true'>&times;</span>
	<span class='sr-only'>Close</span>
</button>

<%# DataBinder.Eval(Container, "Message") %>
