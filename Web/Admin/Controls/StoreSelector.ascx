<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StoreSelector.ascx.cs" Inherits="StoreSelector" %>

<asp:Literal ID='lblText' runat="server"
	Text="<%$ Tokens:StringResource, StoreSelector.Header %>" />

<asp:CheckBoxList ID="lstMultiSelect" runat="server" CssClass="check-box-selector"
	DataTextField="Name" DataValueField="StoreID" />

<asp:RadioButtonList ID="lstSingleSelect" runat="server" CssClass="radio-button-selector"
	OnSelectedIndexChanged="lstSingleSelect_SelectedIndexChanged"
	DataTextField="Name" DataValueField="StoreID" />

<asp:DropDownList ID="cmbSingleList" runat="server" CssClass="drop-down-selector"
	OnSelectedIndexChanged="lstSingleSelect_SelectedIndexChanged"
	DataTextField="Name" DataValueField="StoreID" />