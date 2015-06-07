<%@ Page Language="C#" AutoEventWireup="true" CodeFile="giftcardusage.aspx.cs" Inherits="AspDotNetStorefrontAdmin.giftcardusage" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<h1>
		<i class="fa fa-credit-card"></i>
		<asp:Literal ID="Literal2" runat="server" Text="<%$Tokens:StringResource, admin.giftcardusage.Usage %>" />
	</h1>

	<aspdnsf:AlertMessage runat="server" ID="AlertMessage" />
	<div class="item-action-bar">
		<asp:Hyperlink runat="server" CssClass="btn btn-default" Text="<%$Tokens:StringResource, admin.title.giftcards %>" NavigateUrl="giftcards.aspx" />
		<asp:Hyperlink runat="server" ID="EditLink" CssClass="btn btn-default" Text="<%$Tokens:StringResource, admin.title.editgiftcard %>" />
	</div>
	<div class="white-ui-box">
		<h2>
			<asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.giftcardusage.Serial %>" />
			<span>
				<asp:Literal ID="ltCard" runat="server"></asp:Literal>
			</span>
		</h2>
		<div>
			<div>
				<asp:Literal ID="Literal3" runat="server" Text="<%$Tokens:StringResource, admin.giftcardusage.Balance %>" />
				<asp:Literal ID="ltBalance" runat="server"></asp:Literal>
			</div>
			<p>
				<asp:Literal ID="Literal4" runat="server" Text="<%$Tokens:StringResource, admin.giftcardusage.Adjust %>" />
				<asp:DropDownList ID="ddUsage" runat="server" EnableViewState="False">
					<asp:ListItem Value="-1" Text="<%$Tokens:StringResource, admin.common.Select %>" />
					<asp:ListItem Value="3" Text="<%$Tokens:StringResource, admin.giftcardusage.AddFunds %>" />
					<asp:ListItem Value="4" Text="<%$Tokens:StringResource, admin.giftcardusage.DecrementFunds %>" />
				</asp:DropDownList>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator" ErrorMessage="!" InitialValue="-1" Display="Dynamic" CssClass="text-danger" ControlToValidate="ddUsage" runat="server"></asp:RequiredFieldValidator>
				 
				<asp:Literal ID="Literal5" runat="server" Text="<%$Tokens:StringResource, admin.giftcardusage.Amount %>" />
				<asp:TextBox ID="txtUsage" runat="server" CssClass="text-4" EnableViewState="False" ></asp:TextBox>
				<asp:RangeValidator MinimumValue="-9999" MaximumValue="9999" ID="rangeValidator" runat="server" Type="Currency" CssClass="text-danger" ControlToValidate="txtUsage" ErrorMessage="!"></asp:RangeValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="txtUsage" runat="server"></asp:RequiredFieldValidator>
				 
				<asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.common.OrderNumber %>" />:
				<asp:TextBox ID="txtorderNumber" runat="server" CssClass="text-4" EnableViewState="False"></asp:TextBox>
				<asp:Button ID="btnUsage" CssClass="btn btn-primary btn-sm" Text="<%$Tokens:StringResource, admin.giftcardusage.AddUsage %>" runat="server" OnClick="btnUsage_Click" />
			</p>
			<asp:GridView ID="gMain" runat="server" 
				PagerSettings-Position="TopAndBottom" 
				AutoGenerateColumns="False" 
				AllowPaging="true" 
				PageSize="50" 
				AllowSorting="True" 
				CssClass="table"
				OnRowDataBound="gMain_RowDataBound" 
				OnSorting="gMain_Sorting" 
				OnPageIndexChanging="gMain_PageIndexChanging" 
				GridLines="None">

				<Columns>
					<asp:TemplateField HeaderText="<%$Tokens:StringResource, admin.giftcardusage.ActivityReason %>" SortExpression="UsageTypeID" ItemStyle-CssClass="lighterData">
						<ItemTemplate>
							<%# ((AspDotNetStorefrontCore.GiftCardUsageReasons)DataBinder.Eval(Container.DataItem, "UsageTypeID")).ToString() %>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="<%$Tokens:StringResource, admin.giftcardusage.ByCustomer %>" SortExpression="LastName" ItemStyle-CssClass="lightData">
						<ItemTemplate>
							<span>
								<%# (DataBinder.Eval(Container.DataItem, "FirstName") + " " + DataBinder.Eval(Container.DataItem, "LastName")).Trim() %>
							</span>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="<%$Tokens:StringResource, admin.giftcardusage.OrderNumber %>" SortExpression="OrderNumber" ItemStyle-CssClass="lighterData">
						<ItemTemplate>
							<%# DataBinder.Eval(Container.DataItem, "OrderNumber")%>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="<%$Tokens:StringResource, admin.common.Amount %>" SortExpression="Amount" ItemStyle-CssClass="normalData">
						<ItemTemplate>
							<asp:Literal ID="ltAmount" runat="server"></asp:Literal>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="<%$Tokens:StringResource, admin.giftcardusage.RecordDate %>" SortExpression="CreatedOn" ItemStyle-CssClass="normalData">
						<ItemTemplate>
							<%# DataBinder.Eval(Container.DataItem, "CreatedOn")%>
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
		</div>
	</div>

	<div class="item-action-bar">
		<asp:Hyperlink runat="server" CssClass="btn btn-default" Text="<%$Tokens:StringResource, admin.title.giftcards %>" NavigateUrl="giftcards.aspx" />
		<asp:Hyperlink runat="server" ID="EditLinkBottom" CssClass="btn btn-default" Text="<%$Tokens:StringResource, admin.title.editgiftcard %>" />
	</div>
</asp:Content>
