<%@ Page Language="C#" AutoEventWireup="true" CodeFile="news.aspx.cs" Inherits="AspDotNetStorefrontAdmin.News" MaintainScrollPositionOnPostback="true" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<%@ Register TagPrefix="aspdnsf" Assembly="AspDotNetStorefrontControls" Namespace="AspDotNetStorefrontControls.Listing" %>
<%@ Register TagPrefix="aspdnsf" TagName="StringFilter" Src="Controls/Listing/StringFilter.ascx" %>
<%@ Register TagPrefix="aspdnsf" TagName="BooleanFilter" Src="Controls/Listing/BooleanFilter.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="bodyContentPlaceholder">
	<h1>
		<i class="fa fa-newspaper-o"></i>
		<asp:Label ID="lblHeader" runat="server" Text="<%$Tokens:StringResource, admin.title.news %>" />
	</h1>
	<div>
		<aspdnsf:AlertMessage runat="server" ID="ctrlAlertMessage" />
	</div>

	<aspdnsf:FilteredListing runat="server"
		ID="FilteredListing"
		SqlQuery="SELECT {0} News.NewsID, dbo.GetMlValue(News.Headline, @_locale) Headline, News.Published, News.CreatedOn FROM News WHERE Deleted = 0 AND {1}"
		SortExpression="News.NewsID"
		LocaleSelectionEnabled="true">
		<ActionBarTemplate>
			<asp:HyperLink runat="server" CssClass="btn btn-action" Text="<%$Tokens:StringResource, admin.news.createNews %>" NavigateUrl="newseditor.aspx" />
		</ActionBarTemplate>
		<Filters>
			<aspdnsf:StringFilter runat="server" Label="Headline" FieldName="Headline" />
			<aspdnsf:StringFilter runat="server" Label="Copy" FieldName="NewsCopy" />
			<aspdnsf:BooleanFilter runat="server" Label="Published" FieldName="Published" />
		</Filters>
		<ListingTemplate>
			<div class="white-ui-box">
				<asp:GridView CssClass="table" ID="gMain" runat="server"
					DataSourceID="FilteredListingDataSource"
					PagerSettings-Position="TopAndBottom"
					AutoGenerateColumns="False"
					OnRowDataBound="gMain_RowDataBound"
					OnRowCommand="gMain_RowCommand"
					BorderStyle="None"
					BorderWidth="0px"
					CellPadding="0"
					GridLines="None"
					CellSpacing="-1"
					ShowFooter="True">
					<EmptyDataTemplate>
						<div class="alert alert-info">
							<asp:Literal runat="server" Text="<%$ Tokens:StringResource, admin.common.EmptyDataTemplate.NoResults %>" />
						</div>
					</EmptyDataTemplate>
					<Columns>
						<asp:BoundField
							HeaderText="ID"
							ItemStyle-Width="5%"
							DataField="NewsID" />

						<asp:HyperLinkField
							HeaderText="Headline"
							DataNavigateUrlFields="NewsID"
							DataNavigateUrlFormatString="newseditor.aspx?newsid={0}"
							DataTextField="Headline"
							Text="<%$Tokens:StringResource, admin.nolinktext %>" />

						<asp:BoundField
							HeaderText="Created On"
							ItemStyle-Width="15%"
							DataField="CreatedOn" />

						<asp:TemplateField
							HeaderText="<%$ Tokens: StringResource, admin.common.Published %>">
							<HeaderStyle Width="8%" />
							<ItemTemplate>
								<aspdnsf:CommandCheckBox runat="server"
									ToolTip='<%# (byte)DataBinder.Eval(Container.DataItem, "Published") == 1 ? "Unpublish News Article" : "Publish News Article" %>'
									CheckedCommandName="<%# PublishNewsCommand %>"
									UncheckedCommandName="<%# UnpublishNewsCommand %>"
									CommandArgument='<%# DataBinder.Eval(Container.DataItem, "NewsID") %>'
									AutoPostBack="true"
									OnCommand="DispatchCommand"
									Checked='<%# (byte)DataBinder.Eval(Container.DataItem, "Published") == 1 %>' />
							</ItemTemplate>
						</asp:TemplateField>

						<asp:TemplateField HeaderText="Delete">
							<ItemTemplate>
								<asp:LinkButton ID="lnkDelete" ToolTip="Delete" CssClass="delete-link" CommandName="DeleteItem" CommandArgument='<%# Eval("NewsID") %>' runat="Server">
									<i class="fa fa-times"></i> <asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.common.Delete %>" />
								</asp:LinkButton>
							</ItemTemplate>
							<ItemStyle Width="5%" />
						</asp:TemplateField>
					</Columns>
					<FooterStyle CssClass="gridFooter" />
					<RowStyle CssClass="gridRow" />
					<EditRowStyle CssClass="gridEdit2" />
					<PagerStyle CssClass="tablepagerGrid" />
					<HeaderStyle CssClass="gridHeader" />
					<AlternatingRowStyle CssClass="gridAlternatingRow" BorderWidth="0px" />
				</asp:GridView>
			</div>
		</ListingTemplate>
	</aspdnsf:FilteredListing>
</asp:Content>
