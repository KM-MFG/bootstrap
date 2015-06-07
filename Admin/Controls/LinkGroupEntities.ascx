<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LinkGroupEntities.ascx.cs" Inherits="AspDotNetStorefrontControls.LinkGroupEntities" %>
<%@ Register Src="LinkGroupLinks.ascx" TagPrefix="aspdnsf" TagName="LinkGroupLinks" %>

<aspdnsf:LinkGroupLinks runat="server" ID="LinkGroupLinks"  SelectedLink="<%# SelectedLink %>"/>