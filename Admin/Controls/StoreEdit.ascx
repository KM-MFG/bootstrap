<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StoreEdit.ascx.cs" Inherits="AspDotNetStorefrontAdmin.Controls.StoreEdit" %>

<%@ Register TagPrefix="aspdnsf" Assembly="AspDotNetStorefrontControls" Namespace="AspDotNetStorefrontControls" %>
<%@ Register TagPrefix="AJAX" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register TagPrefix="telerik" Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" %>

<%@ Import Namespace="AspDotNetStorefrontCore" %>
<%@ Import Namespace="System.Linq" %>   

<asp:Panel ID="pnlEditStore" runat="server" DefaultButton="cmdSave">
	<div class="white-ui-box container">
		<div class="white-box-heading">
			<%= this.HeaderText  %>
		</div>
		<div class="alert alert-danger" id="divError" runat="server" visible="false">
            <asp:label runat="server" ID="lblError" />
		</div>
		<asp:Panel ID="pnlMain" Style="text-align: left;" runat="server" Visible="true">
			<div class="form-group">
				<div class="row admin-row">
					<div class="col-xs-2">
						<asp:Label ID="ASPDNSFLabel1" AssociatedControlID="txtStoreName" runat="server" Text="<%$ Tokens:StringResource, Global.StoreName %>" />
					</div>
					<div class="col-xs-10">
						<asp:TextBox ID="txtStoreName" runat="server" class="form-control" Text='<%# Datasource.Name %>' />
					</div>
				</div>
				<div class="row admin-row">
					<div class="col-xs-2">
						<asp:Label ID="lblChkPublished" AssociatedControlID="chkPublished" runat="server" Text="<%$ Tokens:StringResource, StoreControl.Published %>" />
					</div>
					<div class="col-xs-10">
						<asp:CheckBox ID="chkPublished" runat="server" Checked="<%# Datasource.Published %>" Enabled="<%# (Datasource.Deleted == false && Datasource.IsDefault == false) %>" />
					</div>
				</div>
				<div class="row admin-row">
					<div class="col-xs-2">
						<asp:Label ID="lblProdctionURI" AssociatedControlID="txtProductionURI" runat="server" Text="<%$ Tokens:StringResource, admin.storecontrol.ProductionURL %>" />
					</div>
					<div class="col-xs-10">
						<asp:TextBox ID="txtProductionURI" runat="server" class="form-control" Text='<%# Datasource.ProductionURI %>' />
					</div>
				</div>
				<div class="row admin-row">
					<div class="col-xs-2">
						<asp:Label ID="Label1" AssociatedControlID="txtStagingURI" runat="server" Text="<%$ Tokens:StringResource, admin.storecontrol.StagingURL %>" />
					</div>
					<div class="col-xs-10">
						<asp:TextBox ID="txtStagingURI" class="form-control" runat="server" Text='<%# Datasource.StagingURI %>' />
					</div>
				</div>
				<div class="row admin-row">
					<div class="col-xs-2">
						<asp:Label ID="Label2" AssociatedControlID="txtDevURI" runat="server" Text="<%$ Tokens:StringResource, admin.storecontrol.DevelopmentURL %>" />
					</div>
					<div class="col-xs-10">
						<asp:TextBox ID="txtDevURI" CssClass="form-control" runat="server" Text='<%# Datasource.DevelopmentURI %>' />
					</div>
				</div>
				<div class="row admin-row">
					<div class="col-xs-2">
						<asp:Label ID="lblSkinID" AssociatedControlID="cmbSkinID" runat="server" Text="<%$ Tokens:StringResource, admin.common.Skin %>" />
					</div>
					<div class="col-xs-10">
						<asp:DropDownList ID="cmbSkinID" class="text-lg" runat="server" />
					</div>
				</div>
				<div class="row admin-row">
					<div class="col-xs-2">
						<asp:Label ID="lblDescription" AssociatedControlID="txtDescription" runat="server" Text="<%$ Tokens:StringResource, StoreControl.Description %>" />
					</div>
					<div class="col-xs-10">
						<asp:TextBox ID="txtDescription" runat="server" class="form-control" TextMode="MultiLine" Text='<%# Datasource.Description %>' />
					</div>
				</div>
                <asp:PlaceHolder runat="server" ID="phRegisterWithBuySafe" Visible="false">
                    <div class="row admin-row">
                        <div class="col-xs-2">
						    <asp:Label ID="Label3" AssociatedControlID="cbxBuySafe" runat="server" Text="<%$ Tokens:StringResource, admin.storecontrol.AddToBuySafe %>" />
					    </div>
					    <div class="col-xs-10">
						    <asp:CheckBox ID="cbxBuySafe" runat="server" Checked="true" />
                            See <a href="http://www.aspdotnetstorefront.com/linkmanager.aspx?topic=9500manual&type=buysafe" target="_blank">Manual</a>
					    </div>	
					</div>
				</asp:PlaceHolder>
				<div style="text-align: center" class="modal_popup_Footer">
					<asp:Button ID="cmdSave" runat="server" CssClass="btn btn-primary btn-sm" Text="<%$ Tokens:StringResource, admin.common.save %>" CommandName="UpdateStore" CommandArgument="<%# Datasource.StoreID %>" OnClick="cmdSave_Click" />
					<asp:Button ID="cmdCancel" runat="server" CssClass="btn btn-default btn-sm" Text="<%$ Tokens:StringResource, admin.common.cancel %>" />
                    <%--<asp:Button ID="cmdUpdateLicense" runat="server" 
                    Text="<%$ Tokens:StringResource, StoreControl.UpdateLicense %>" 
                    Visible='<%# Datasource.ProductionURILicensed == false || Datasource.StagingURILicensed == false || Datasource.DevelopmentURILicensed == false %>' Enabled="false" />--%>
                </div>                                                
                <%--Target control that will trigger this popup is not contained here so we use the PoupControlId property as reference instead--%>
				<AJAX:ModalPopupExtender ID="extEditStorePanel" runat="server"
                    PopupControlID="pnlEditStore" 
                    BackgroundCssClass="modal_popup_background" 
					CancelControlID="cmdCancel">
				</AJAX:ModalPopupExtender>
			</div>
		</asp:Panel>
	</div>
</asp:Panel>