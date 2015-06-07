<%@ Page Language="c#" Inherits="AspDotNetStorefrontAdmin.entityBulkDisplayOrder"
	CodeFile="entitybulkdisplayorder.aspx.cs" MaintainScrollPositionOnPostback="true" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceholder" runat="server">
	<div id="container">
		<div class="wrapper row" id="divwrapper" runat="server">
			<asp:Panel ID="pnlSubEntityList" runat="server" Visible="false">
				<h3>
					<asp:Label ID="lblpagehdr" runat="server" Visible="false"></asp:Label>
				</h3>
				<div class="list-action-bar">
					<asp:Button ID="btnBackToEntityEdit" runat="server" CssClass="btn btn-default btn-sm" OnClick="btnBackToEntityEdit_Click" />
					<asp:Button ID="btnTopUpdate" runat="server" Text="Update Order" CssClass="btn btn-default btn-sm" OnClick="UpdateDisplayOrder" />
				</div>
				<div class="white-ui-box">
					<table border="0" style="width: 100%; text-align: left">
						<asp:Repeater ID="subcategories" runat="server">
							<HeaderTemplate>
								<tr class="table-header">
									<th style="width: 33%">
										<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.common.ID %>" />
									</th>
									<th style="width: 33%">
										<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.common.Name %>" />
									</th>
									<th style="width: 33%">
										<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.common.DisplayOrder %>" />
									</th>
								</tr>
							</HeaderTemplate>
							<ItemTemplate>
								<tr class="table-row2">
									<td>
										<%# ((System.Xml.XmlNode)Container.DataItem)["EntityID"].InnerText%>
									</td>
									<td>
										<%# getLocaleValue(((System.Xml.XmlNode)Container.DataItem)["Name"], AspDotNetStorefrontCore.Localization.GetDefaultLocale())%>
									</td>
									<td>
										<asp:TextBox ID="DisplayOrder" runat="server" Columns="4" Text='<%# ((System.Xml.XmlNode)Container.DataItem)["DisplayOrder"].InnerText%>'></asp:TextBox>
										<asp:TextBox ID="entityid" runat="server" Visible="false" Text='<%# ((System.Xml.XmlNode)Container.DataItem)["EntityID"].InnerText%>'></asp:TextBox>
									</td>
								</tr>
							</ItemTemplate>
							<AlternatingItemTemplate>
								<tr class="table-alternatingrow2">
									<td>
										<%# ((System.Xml.XmlNode)Container.DataItem)["EntityID"].InnerText%>
									</td>
									<td>
										<%# getLocaleValue(((System.Xml.XmlNode)Container.DataItem)["Name"], "en-US") %>
									</td>
									<td>
										<asp:TextBox ID="DisplayOrder" runat="server" Columns="4" Text='<%# ((System.Xml.XmlNode)Container.DataItem)["DisplayOrder"].InnerText%>'></asp:TextBox>
										<asp:TextBox ID="entityid" runat="server" Visible="false" Text='<%# ((System.Xml.XmlNode)Container.DataItem)["EntityID"].InnerText%>'></asp:TextBox>
									</td>
								</tr>
							</AlternatingItemTemplate>
							<FooterTemplate>
							</FooterTemplate>
						</asp:Repeater>
					</table>
				</div>
				<div class="list-action-bar">
					<asp:Button ID="btnBotUpdate" runat="server" Text="Update Order" class="btn btn-default btn-sm"
						OnClick="UpdateDisplayOrder" />
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlNoSubEntities" runat="server" Visible="true" HorizontalAlign="Center"
				Style="padding-top: 30px;">
				<asp:Label ID="lblError" runat="server" Font-Bold="true" Font-Names="verdana"></asp:Label>
			</asp:Panel>
		</div>
	</div>
</asp:Content>
