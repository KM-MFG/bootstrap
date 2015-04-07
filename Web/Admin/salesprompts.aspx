<%@ Page Language="C#" AutoEventWireup="true" CodeFile="salesprompts.aspx.cs" Inherits="AspDotNetStorefrontAdmin.salesprompts" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<%@ Register TagPrefix="aspdnsf" TagName="LinkGroupProducts" Src="Controls/LinkGroupProducts.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<h1>
		<i class="fa fa-cube"></i>
		<asp:Literal runat="server" ID="litHeader" />
	</h1>
	<aspdnsf:AlertMessage runat="server" ID="ctrlAlertMessage" />

	<div id="container">
		<asp:Panel runat="server" ID="pnlGrid" DefaultButton="btnInsert">
			<div class="item-action-bar">
				<aspdnsf:LinkGroupProducts runat="server" ID="LinkGroupProducts" SelectedLink="salesprompts.aspx" />
				<asp:Button runat="server" ID="btnInsert" CssClass="btn btn-action" Text="<%$Tokens:StringResource, admin.editsalesprompt.CreateSalesPrompt %>" OnClick="btnInsert_Click" />
			</div>
			<div class="white-ui-box">

				<asp:GridView ID="gMain" runat="server"
					AutoGenerateColumns="False"
					CssClass="table"
					OnRowCancelingEdit="gMain_RowCancelingEdit"
					OnRowCommand="gMain_RowCommand"
					OnRowDataBound="gMain_RowDataBound"
					OnRowUpdating="gMain_RowUpdating"
					OnRowEditing="gMain_RowEditing"
					CellPadding="0"
					GridLines="None"
					AllowPaging="true" 
					AllowSorting="true" 
					OnSorting="gMain_Sorting">
					<Columns>
						<asp:BoundField DataField="SalesPromptID" HeaderText="ID" ReadOnly="True" SortExpression="SalesPromptID" />
						<asp:TemplateField HeaderText="Sales Prompt" SortExpression="Name">
							<ItemTemplate>
								<asp:Literal runat="server" ID="ltName" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' />
							</ItemTemplate>
							<EditItemTemplate>
								<%# DataBinder.Eval(Container.DataItem, "EditName") %>
							</EditItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="<%$ Tokens: StringResource, admin.common.Delete %>">
							<ItemTemplate>
								<asp:LinkButton ID="Delete" CommandName="DeleteItem" CommandArgument='<%# Eval("SalesPromptID") %>' runat="Server" Text='<i class="fa fa-times"></i> Delete' CssClass="delete-link" />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField Visible="False" DataField="EditName" ReadOnly="True" />
						<asp:CommandField HeaderText="<%$ Tokens: StringResource, admin.common.Edit %>" ItemStyle-Width="10%" ButtonType="Link" ShowEditButton="True" ControlStyle-CssClass="edit-link" CancelText='<i class="fa fa-reply"></i> Cancel' EditText='<i class="fa fa-share"></i> Edit' UpdateText='<i class="fa fa-floppy-o"></i> Save' />
					</Columns>
					<SelectedRowStyle CssClass="grid-view-action" />
				</asp:GridView>
			</div>
			<div class="item-action-bar">
				<aspdnsf:LinkGroupProducts runat="server" SelectedLink="salesprompts.aspx" />
				<asp:Button runat="server" CssClass="btn btn-action" Text="<%$Tokens:StringResource, admin.common.addnew %>" OnClick="btnInsert_Click" />
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlAdd" runat="server" DefaultButton="btnSubmit">
			<div class="white-ui-box">
				<label>Sales Prompt:</label>
				<asp:Literal ID="ltPrompt" runat="server" />
				<asp:ValidationSummary ValidationGroup="gAdd" ID="validationSummary" runat="server" EnableClientScript="true" ShowMessageBox="true" ShowSummary="false" Enabled="true" />
			</div>
			<div class="item-action-bar">
				<asp:Button ValidationGroup="gAdd" CssClass="btn btn-primary btn-sm" ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Save" />
				<asp:Button ID="btnCancel" CssClass="btn btn-default btn-sm" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
			</div>
		</asp:Panel>
	</div>
</asp:Content>