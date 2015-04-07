<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IntegerFilter.ascx.cs" Inherits="AspDotNetStorefrontControls.Listing.IntegerFilter" %>

<div class="form-group has-feedback">
	<label class="control-label"><%# Label %></label>
	<span class="feedback-icon">
		<input
			type="text"
			class="form-control"
			value='<%# Value %>'
			name='<%# ValueFilterName %>'
			data-bv-integer="true"
			data-bv-integer-message="Invalid number" />
	</span>
</div>
