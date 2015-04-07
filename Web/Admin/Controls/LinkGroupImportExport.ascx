<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LinkGroupImportExport.ascx.cs" Inherits="AspDotNetStorefrontControls.LinkGroupImportExport" %>
<%@ Register Src="LinkGroupLinks.ascx" TagPrefix="aspdnsf" TagName="LinkGroupLinks" %>

<aspdnsf:LinkGroupLinks runat="server" ID="LinkGroupLinks"  SelectedLink="<%# SelectedLink %>"/>