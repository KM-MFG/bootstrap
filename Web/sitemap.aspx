<%@ Page Language="c#" Inherits="AspDotNetStorefront.sitemap" CodeFile="sitemap.aspx.cs" MasterPageFile="~/App_Templates/Skin_1/template.master" %>
<%@ Register TagPrefix="aspdnsf" TagName="XmlPackage" Src="~/Controls/XmlPackageControl.ascx" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="PageContent">
    <asp:Panel ID="pnlContent" runat="server" >
        <aspdnsf:XmlPackage runat="server" PackageName="page.sitemap.xml.config" ID="SiteMapXmlPackage" />
    </asp:Panel>
</asp:Content>
