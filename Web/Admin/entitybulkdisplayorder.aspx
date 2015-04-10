<%@ Page Language="c#" Inherits="AspDotNetStorefrontAdmin.EntityBulkDisplayOrder"
	CodeFile="entitybulkdisplayorder.aspx.cs" MaintainScrollPositionOnPostback="true" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceholder" runat="server">
	<div id="container">
		<div class="wrapper row" id="divwrapper" runat="server">
			<h1 runat="server" id="header">
				<i class="fa fa-ellipsis-v"></i>
				<asp:Label ID="lblHeader" runat="server" Text="<%$Tokens:StringResource, admin.menu.DisplayOrder %>" />
			</h1>

			<div>
				<asp:Label ID="lblHeaderTip" runat="server" Text="<%$Tokens:StringResource, admin.displayorder.HeaderTip %>" />
			</div>

			<aspdnsf:AlertMessage runat="server" ID="AlertMessageDisplay" />

			<div class="list-action-bar">
				<asp:Panel ID="pnlEntityType" runat="server" CssClass="other-actions" >
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.entity.SelectEntityType %>" AssociatedControlID="ddEntityType" />
					<asp:DropDownList ID="ddEntityType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddEntityType_SelectedIndexChanged" >
						<asp:ListItem Text="<%$ Tokens:StringResource, admin.menu.Categories %>" Value="Category" Selected="true" />
						<asp:ListItem Text="<%$ Tokens:StringResource, admin.menu.Manufacturers %>" Value="Manufacturer" />
						<asp:ListItem Text="<%$ Tokens:StringResource, admin.menu.Sections %>" Value="Section" />
					</asp:DropDownList>
				</asp:Panel>
				<asp:Button ID="btnTopUpdate" runat="server" CausesValidation="true" ValidationGroup="valUpdate" Text="<%$Tokens:StringResource, admin.common.Save %>" CssClass="btn btn-primary" OnClick="UpdateDisplayOrder" />
			</div>

			<div class="white-ui-box">
				<asp:GridView runat="server"
					ID="grdDisplayOrder"
					CssClass="table js-sortable-gridview"
					GridLines="None" 
					DataKeyNames="EntityId"
					AutoGenerateColumns="false"
					OnDataBinding="grdDisplayOrder_DataBinding">
					<EmptyDataTemplate>
						<div class="alert alert-info">
							<asp:Literal runat="server" Text="<%$ Tokens:StringResource, admin.common.EmptyDataTemplate.NoResults %>" />
						</div>
					</EmptyDataTemplate>
					<Columns>
						<asp:HyperLinkField
							HeaderText="<%$ Tokens: StringResource, admin.common.ID %>"
							HeaderStyle-Width="7%"
							DataTextField="EntityID" 
							DataNavigateUrlFields="EntityID,EntityType"
							DataNavigateUrlFormatString="entity.aspx?entityid={0}&entityname={1}" />

						<asp:BoundField HeaderText="<%$Tokens:StringResource, admin.common.Name %>" DataField="Name" />

						<asp:TemplateField HeaderText="<%$Tokens:StringResource, admin.common.DisplayOrder %>">
							<ItemTemplate>
								<asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="form-control-short" Text='<%# Eval("DisplayOrder") %>' />
							<asp:RequiredFieldValidator ErrorMessage="Fill in Display Order!" CssClass="text-danger" 
								ControlToValidate="txtDisplayOrder" ID="reqDisplayOrder" Display="Dynamic" 
								ValidationGroup="valUpdate" SetFocusOnError="true" runat="server" />
							<asp:CompareValidator ErrorMessage="Whole numbers only!" CssClass="text-danger" Operator="DataTypeCheck"
								 ControlToValidate="txtDisplayOrder" Type="Integer" ValidationGroup="valUpdate" 
								ID="cmpDisplayOrder" runat="server" Display="Dynamic" />	
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
				</asp:GridView>
			</div>

			<div class="list-action-bar">
				<asp:Button ID="btnBotUpdate" CausesValidation="true" ValidationGroup="valUpdate" runat="server" Text="<%$Tokens:StringResource, admin.common.Save %>" class="btn btn-primary" OnClick="UpdateDisplayOrder" />
			</div>
		</div>
	</div>
</asp:Content>
