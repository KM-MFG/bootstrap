<%@ Page Language="C#" CodeFile="dotfeedadmincloudconnector.aspx.cs" Inherits="AspDotNetStorefrontAdmin.dotfeedadmincloudconnector" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<asp:HiddenField ID="AdnsfBaseUrl" ClientIDMode="Static" runat="server" />
	<asp:HiddenField ID="DotFeedBaseUrl" ClientIDMode="Static" runat="server" />
	<aspdnsf:AlertMessage runat="server" ID="AlertMessageDisplay" />
	<asp:Panel ID="Disconnected" runat="server" Visible="false">
		<iframe src="http://www.aspdotnetstorefront.com/linkmanager.aspx?topic=9500dotfeed&type=gscrefresh" frameborder="0" style="overflow:hidden;height:90%;width:90%;position:absolute;" height="100%" width="100%"></iframe>
	</asp:Panel>
	<asp:Literal ID="CloudConnectorContainer" runat="server" Visible="false" />
</asp:Content>