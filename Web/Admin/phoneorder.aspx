<%@ Page Language="C#" AutoEventWireup="true" CodeFile="phoneorder.aspx.cs" Inherits="AspDotNetStorefrontAdmin.phoneorder" MasterPageFile="~/App_Templates/Admin_Default/AdminMaster.master" %>

<%@ Register TagPrefix="aspdnsf" Namespace="AspDotNetStorefrontControls.Validators" Assembly="AspDotNetStorefrontControls" %>

<asp:Content ContentPlaceHolderID="bodyContentPlaceholder" runat="server">
	<h1>
		<i class="fa fa-phone"></i>
		<asp:Literal runat="server" Text="<%$Tokens:StringResource, admin.title.phoneorder %>" />
	</h1>

	<asp:Literal ID="saveOrderNumber" runat="server" Visible="false" />
	<div id="helporderedit" runat="server" visible="false">
		<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.EditOrderNumber %>" />
		- 
		<asp:Label ID="txtordernumber" runat="server" />
		- 
		<asp:HyperLink runat="server" ID="backtoorderlink" Text="Cancel" />
	</div>
	<asp:Panel runat="server" ID="TopPanel" DefaultButton="btnSearch" CssClass="white-ui-box">
		<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.FindExistingCustomer %>" />
		<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSearch" ErrorMessage="<%$Tokens:StringResource, admin.phoneorder.validator.RequiredMessage %>" SetFocusOnError="True" ValidationGroup="Search" Font-Bold="True"></asp:RequiredFieldValidator>
		<asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
		<asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" Text="Search" OnClick="btnSearch_Click" ValidationGroup="Search" />
		&nbsp; &nbsp;&nbsp; or &nbsp; &nbsp;&nbsp; &nbsp;<asp:Button ID="btnCreateCustomerTop" runat="server" CssClass="btn btn-action" Text="<%$Tokens:StringResource, admin.phoneorder.button.CreateNewCustomer %>" OnClick="btnCreateCustomerTop_Click" /><br />
		<small>
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.CustomerSearch %>" /></small>
	</asp:Panel>
	<asp:Panel ID="SearchCustomerPanel" runat="server" CssClass="white-ui-box" Visible="False">
		<div class="white-box-heading">
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.MatchingCustomers %>" />
		</div>
		<asp:GridView ID="GridView1" runat="server"
			DataKeyNames="CustomerID"
			OnRowCommand="GridView1_RowCommand"
			AutoGenerateColumns="False"
			CssClass="table"
			GridLines="None">
			<Columns>
				<asp:BoundField DataField="CustomerID" HeaderText="<%$Tokens:StringResource, admin.common.CustomerID %>">
					<HeaderStyle HorizontalAlign="Left" />
				</asp:BoundField>
				<asp:BoundField DataField="FirstName" HeaderText="<%$Tokens:StringResource, admin.phoneorder.header.FirstName %>">
					<HeaderStyle HorizontalAlign="Left" />
				</asp:BoundField>
				<asp:BoundField DataField="LastName" HeaderText="<%$Tokens:StringResource, admin.phoneorder.header.LastName %>">
					<HeaderStyle HorizontalAlign="Left" />
				</asp:BoundField>
				<asp:BoundField DataField="EMail" HeaderText="<%$Tokens:StringResource, admin.menu.MailingTest %>">
					<HeaderStyle HorizontalAlign="Left" />
				</asp:BoundField>
				<asp:ButtonField ButtonType="Button" CommandName="Select" Text="<%$Tokens:StringResource, admin.phoneorder.button.Select %>" ControlStyle-CssClass="btn btn-default btn-sm">
					<ControlStyle Font-Size="X-Small" />
					<ItemStyle HorizontalAlign="Center" />
					<HeaderStyle HorizontalAlign="Center" />
				</asp:ButtonField>
			</Columns>
			<HeaderStyle CssClass="table-header" />
			<AlternatingRowStyle CssClass="table-alternatingrow2" />
			<RowStyle CssClass="table-row2" />
		</asp:GridView>
	</asp:Panel>
	<asp:Panel ID="CreateNewCustomerPanel" runat="server" CssClass="white-ui-box" Visible="False">
		<asp:Panel ID="CustomerIDPanel" CssClass="white-box-heading" runat="server" Visible="false">
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.CustomerID %>" />
			<asp:Literal ID="CustomerID" runat="server" />
			)
		</asp:Panel>

		<table class="table table-detail phone-order-customer-create">
			<tr>
				<td align="right">
					<span class="text-danger">*</span><asp:Label ID="Label3" runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.FirstName %>" />
				</td>
				<td>
					<asp:TextBox TabIndex="1" ID="FirstName" runat="server" Width="200" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator123" runat="server" ControlToValidate="FirstName" ErrorMessage="First Name Required!"></asp:RequiredFieldValidator>
				</td>
				<td align="right">
					<span class="text-danger">*</span><asp:Label ID="Label2" runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.LastName %>" />
				</td>
				<td>
					<asp:TextBox TabIndex="2" ID="LastName" runat="server" Width="200" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator3" runat="server" ControlToValidate="LastName" ErrorMessage="Last Name Required!"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td align="right">
						<asp:Label ID="lblRequiredEmailAsterix" runat="server" Visible="false"><span class="text-danger">*</span></asp:Label>
						<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Email %>" />
				</td>
				<td>
					<asp:TextBox TabIndex="3" ID="EMail" runat="server" Width="200" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredEmailValidator" Enabled="false" runat="server" ControlToValidate="EMail"><br />E-Mail Required!</asp:RequiredFieldValidator>
					<aspdnsf:EmailValidator CssClass="text-danger" ID="valRegExValEmail" ControlToValidate="EMail" runat="SERVER" ErrorMessage="<%$Tokens:StringResource, admin.common.ValidE-MailAddressPrompt %>" />
					<asp:Label ID="EMailAlreadyTaken" Text="<%$Tokens:StringResource, admin.phoneorder.label.EmailTaken %>" Visible="False" runat="server" Font-Bold="True" Font-Size="X-Small" ForeColor="Red"></asp:Label>
				</td>
				<td align="right">
					<span class="text-danger">*</span><asp:Label ID="Label1" runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Phone %>" />
				</td>
				<td>
					<asp:TextBox TabIndex="4" ID="Phone" runat="server" Width="200" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator15" runat="server" ControlToValidate="Phone"><br />Phone Number Required!</asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.OkToEmail %>" /></td>
				<td>
					<asp:RadioButtonList TabIndex="5" ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
						<asp:ListItem Selected="True" Value="Yes" Text="<%$Tokens:StringResource, admin.common.Yes %>"></asp:ListItem>
						<asp:ListItem Text="<%$Tokens:StringResource, admin.common.No %>"></asp:ListItem>
					</asp:RadioButtonList>
				</td>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Over13Years %>" /></td>
				<td>
					<asp:CheckBox TabIndex="6" ID="Over13" runat="server" Checked="True" /></td>
			</tr>
			<tr>
				<td align="right">
					<asp:Literal ID="AffiliatePrompt" Text="<%$Tokens:StringResource, admin.order.Affiliate %>" runat="server"></asp:Literal></td>
				<td>
					<asp:DropDownList TabIndex="7" ID="AffiliateList" runat="server" DataTextField="Name" DataValueField="AffiliateID"></asp:DropDownList></td>
				<td align="right">
					<asp:Literal ID="CustomerLevelPrompt" Text="<%$Tokens:StringResource, admin.phoneorder.CustomerLevel %>" runat="server"></asp:Literal></td>
				<td>
					<asp:DropDownList TabIndex="8" ID="CustomerLevelList" runat="server" DataTextField="Name" DataValueField="CustomerLevelID"></asp:DropDownList></td>
			</tr>
			<tr>
				<td colspan="2">
					<br />
					<b>
						<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.BillingInfo %>" />
						<asp:Button TabIndex="9" ID="btnCopyAccount" runat="server" CssClass="btn btn-default btn-sm" Text="<%$Tokens:StringResource, admin.phoneorder.button.CopyFromAccount %>" /></b><br />
					<br />
				</td>
				<td colspan="2">
					<br />
					<b>
						<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.ShippingInfo %>" />
						<asp:Button TabIndex="10" ID="btnCopyBilling" runat="server" CssClass="btn btn-default btn-sm" Text="<%$Tokens:StringResource, admin.phoneorder.button.CopyFromBilling %>" /></b><br />
					<br />
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.FirstName %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="11" runat="server" ID="BillingFirstName" MaxLength="50" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator4" runat="server" ControlToValidate="BillingFirstName" ErrorMessage="First Name Required!"></asp:RequiredFieldValidator>
				</td>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.FirstName %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="31" runat="server" ID="ShippingFirstName" MaxLength="50" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator5" runat="server" ControlToValidate="ShippingFirstName" ErrorMessage="First Name Required!"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.LastName %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="12" runat="server" ID="BillingLastName" MaxLength="50" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator6" runat="server" ControlToValidate="BillingLastName" ErrorMessage="Last Name Required!"></asp:RequiredFieldValidator>
				</td>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.LastName %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="32" runat="server" ID="ShippingLastName" MaxLength="50" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator7" runat="server" ControlToValidate="ShippingLastName" ErrorMessage="Last Name Required!"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td align="right"><span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Phone %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="13" runat="server" ID="BillingPhone" MaxLength="25" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator2" runat="server" ControlToValidate="BillingPhone" ErrorMessage="Phone Number Required!"></asp:RequiredFieldValidator>
				</td>
				<td align="right"><span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Phone %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="33" runat="server" ID="ShippingPhone" MaxLength="25" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator14" runat="server" ControlToValidate="ShippingPhone" ErrorMessage="Phone Number Required!"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.order.Company %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="14" runat="server" ID="BillingCompany" MaxLength="100" autocomplete="off"></asp:TextBox></td>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.order.Company %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="34" runat="server" ID="ShippingCompany" MaxLength="100" autocomplete="off"></asp:TextBox></td>
			</tr>
			<tr>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.AddressType %>" /></td>
				<td width="25%">
					<asp:DropDownList TabIndex="15" ID="BillingResidenceType" runat="server">
						<asp:ListItem Value="0">Unknown</asp:ListItem>
						<asp:ListItem Value="1" Selected="True">Residential</asp:ListItem>
						<asp:ListItem Value="2">Commercial</asp:ListItem>
					</asp:DropDownList></td>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.AddressType %>" /></td>
				<td width="25%">
					<asp:DropDownList TabIndex="35" ID="ShippingResidenceType" runat="server">
						<asp:ListItem Value="0">Unknown</asp:ListItem>
						<asp:ListItem Value="1" Selected="True">Residential</asp:ListItem>
						<asp:ListItem Value="2">Commercial</asp:ListItem>
					</asp:DropDownList></td>
			</tr>
			<tr>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Address1 %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="16" runat="server" ID="BillingAddress1" MaxLength="100" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator8" runat="server" ControlToValidate="BillingAddress1" ErrorMessage="Address 1 Required!"></asp:RequiredFieldValidator>
				</td>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Address1 %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="36" runat="server" ID="ShippingAddress1" MaxLength="100" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator9" runat="server" ControlToValidate="ShippingAddress1" ErrorMessage="Address 1 Required!"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Address2 %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="17" runat="server" ID="BillingAddress2" MaxLength="100" autocomplete="off"></asp:TextBox></td>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Address2 %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="37" runat="server" ID="ShippingAddress2" MaxLength="100" autocomplete="off"></asp:TextBox></td>
			</tr>
			<tr>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Suite %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="18" runat="server" ID="BillingSuite" MaxLength="50" autocomplete="off"></asp:TextBox></td>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Suite %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="38" runat="server" ID="ShippingSuite" MaxLength="50" autocomplete="off"></asp:TextBox></td>
			</tr>
			<tr>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.City %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="19" runat="server" ID="BillingCity" MaxLength="50" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator10" runat="server" ControlToValidate="BillingCity" ErrorMessage="City Required!"></asp:RequiredFieldValidator>
				</td>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.City %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="39" runat="server" ID="ShippingCity" MaxLength="50" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator11" runat="server" ControlToValidate="ShippingCity" ErrorMessage="City Required!"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td align="right" style="height: 22px">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.State %>" /></td>
				<td style="height: 22px">
					<asp:DropDownList TabIndex="20" ID="BillingState" runat="server" DataTextField="Name" DataValueField="Abbreviation"></asp:DropDownList></td>
				<td align="right" style="height: 22px">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.State %>" /></td>
				<td style="height: 22px">
					<asp:DropDownList TabIndex="40" ID="ShippingState" runat="server" DataTextField="Name" DataValueField="Abbreviation"></asp:DropDownList></td>
			</tr>
			<tr>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Zip %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="21" runat="server" ID="BillingZip" MaxLength="10" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator12" runat="server" ControlToValidate="BillingZip" ErrorMessage="Zip Required!"></asp:RequiredFieldValidator>
				</td>
				<td align="right">
					<span class="text-danger">*</span><asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Zip %>" /></td>
				<td width="25%">
					<asp:TextBox TabIndex="41" runat="server" ID="ShippingZip" MaxLength="10" autocomplete="off"></asp:TextBox>
					<asp:RequiredFieldValidator CssClass="text-danger" ID="RequiredFieldValidator13" runat="server" ControlToValidate="ShippingZip" ErrorMessage="Zip Required!"></asp:RequiredFieldValidator>
				</td>
			</tr>
			<tr>
				<td align="right"></td>
				<td width="25%">
					<aspdnsf:ZipCodeValidator CssClass="text-danger" ControlToValidate="BillingZip" ID="valBillingZip" Display="Dynamic" runat="server"></aspdnsf:ZipCodeValidator>
				</td>
				<td align="right"></td>
				<td width="25%">
					<aspdnsf:ZipCodeValidator CssClass="text-danger" ControlToValidate="ShippingZip" ID="valShippingZip" Display="Dynamic" runat="server"></aspdnsf:ZipCodeValidator>
				</td>
			</tr>
			<tr>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Country %>" /></td>
				<td width="25%">
					<asp:DropDownList TabIndex="22" ID="BillingCountry" runat="server" DataTextField="Name" DataValueField="Name"></asp:DropDownList></td>
				<td align="right">
					<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.Country %>" /></td>
				<td width="25%">
					<asp:DropDownList TabIndex="42" ID="ShippingCountry" runat="server" DataTextField="Name" DataValueField="Name"></asp:DropDownList></td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<br />
					<asp:Button ID="btnCreateCustomer" TabIndex="43" runat="server" CssClass="btn btn-action" Text="<%$Tokens:StringResource, admin.phoneorder.button.CreateCustomer %>" Visible="false" OnClick="btnCreateCustomer_Click" />
					&nbsp;
					<asp:Button ID="btnUpdateCustomer" TabIndex="44" runat="server" CssClass="btn btn-default" Text="<%$Tokens:StringResource, admin.phoneorder.button.UpdateCustomer %>" Visible="false" OnClick="btnUpdateCustomer_Click" />
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
					<asp:Button ID="btnUseCustomer" runat="server" CssClass="btn btn-primary" Text="<%$Tokens:StringResource, admin.phoneorder.button.UseCustomer %>" Visible="false" OnClick="btnUseCustomer_Click" /></td>
			</tr>
		</table>
	</asp:Panel>
	<asp:Panel ID="CustomerStatsPanel" runat="server" Visible="false">
		<div class="alert alert-info">
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.CreatingOrderForCustomer %>" />
			<asp:Literal ID="UsingCustomerID" runat="server" />
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.UsingFirstName %>" />
			<asp:Literal ID="UsingFirstName" runat="server" />
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.UsingLastName %>" />
			<asp:Literal ID="UsingLastName" runat="server" />
			<asp:Label runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.label.UsingEmail %>" />
			<asp:Literal ID="UsingEMail" runat="server" />
		</div>
		<div class="item-action-bar">
			<asp:Button ID="btnReEditCustomer" CssClass="btn btn-default" runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.button.ReEditCustomer %>" OnClick="btnReEditCustomer_Click" />
			<asp:Button ID="btnRestartImpersonation" CssClass="btn btn-default" runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.button.ReStartImpersonation %>" OnClick="btnRestartImpersonation_Click" />
			<asp:Button ID="btnClearFailedTransaction" CssClass="btn btn-default" runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.button.ClearFailedTX %>" OnClick="btnClearFailedTransaction_Click" />
			<asp:Button ID="btnCancelOrder" CssClass="btn btn-default" runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.button.CancelOrder %>" OnClick="btnCancelOrder_Click" />
			<asp:Button ID="btnDoneOrder" CssClass="btn btn-default" runat="server" Text="<%$Tokens:StringResource, admin.phoneorder.button.DoneOrder %>" OnClick="btnDoneOrder_Click" />
			<asp:Button ID="btnResetToMatchOriginal" CssClass="btn btn-default" runat="server" Visible="false" Text="<%$Tokens:StringResource, admin.phoneorder.button.EditResetToMatchOriginalOrder %>" OnClick="btnResetToMatchOriginal_Click" />
			<asp:Button ID="btnEditClearCart" CssClass="btn btn-default" runat="server" Visible="false" Text="<%$Tokens:StringResource, admin.phoneorder.button.EditClearCart %>" OnClick="btnEditClearCart_Click" />
			<asp:Button ID="btnEditViewOldReceipt" CssClass="btn btn-default" runat="server" Visible="false" Text="<%$Tokens:StringResource, admin.phoneorder.button.EditViewOldReceipt %>" OnClick="btnEditViewOldReceipt_Click" />
		</div>
	</asp:Panel>
	<asp:Panel ID="ImpersonationPanel" runat="Server" Visible="false">
		<iframe id="ImpersonationFrame" frameborder="1" style="height: 600px; overflow: visible; width: 100%;" runat="server" scrolling="auto"></iframe>
	</asp:Panel>

</asp:Content>
