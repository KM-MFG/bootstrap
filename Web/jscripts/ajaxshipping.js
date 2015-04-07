adnsf$(document).ready(function () {
	adnsf$('#AjaxShippingLoader').hide();
	adnsf$('#AjaxShippingError').hide();

	//add handlers
	adnsf$('#Country').change(function () {
		ajaxShippingFormReset(false, true, true);
	});
	adnsf$('#State').change(function () {
		ajaxShippingFormReset(false, false, true);
	});
});
adnsf$(window).load(function () {
	//after document ready
	ajaxShippingFormReset(true, true, true);
});


function ajaxShippingFormReset(resetCountry, resetState, resetPostal)
{
	//clear form fields
	Cookies.erase('countrycookie');
	Cookies.erase('statecookie');
	Cookies.erase('postalcookie');

	if (resetCountry) {
		adnsf$('#Country').find('option:first').attr('selected', 'selected');
	}
	if (resetState) {
		adnsf$('#State').find('option:first').attr('selected', 'selected');
	}
	if (resetPostal) {
		adnsf$('#PostalCode').val('');
	}
}

function makeHttpRequest(url, element, calltype) {
	adnsf$('#AjaxShippingLoader').show();
	adnsf$('#AjaxShippingError').hide();

	adnsf$.ajax({
		type: 'GET',
		url: url,
	})
	.done(function (xml) {
		adnsf$('#AjaxShippingLoader').hide();
		adnsf$('#AjaxShippingQuote').show();
		loadXML(xml, calltype);
	})
	.fail(function () {
		alert('Loading data failed.');
	});
}

function loadXML(xml, calltype) {
	if (calltype === 'shipping') {
		var string = '<div class="ajax-shipping-results">';
		var root = xml.getElementsByTagName('Shipping')[0];
		for (i = 0; i < root.childNodes.length; i++) {
			var node = root.childNodes[i].tagName;
			string += "<div>" + root.getElementsByTagName(node)[0].childNodes[0].nodeValue + "</div>";
		}
		string += "</div>";
		if (document.getElementById('AjaxShippingQuote')) {
			document.getElementById('AjaxShippingQuote').innerHTML = string;
		}
	}
	if (calltype === 'pricing') {
		var prnode = xml.getElementsByTagName('PriceHTML')[0];
		var variantnode = xml.getElementsByTagName('VariantID')[0];
		var NewPrice = "Not Found";
		var VariantID = "0";
		if (prnode !== undefined) {
			NewPrice = xml.getElementsByTagName('PriceHTML')[0].firstChild.data
		}
		if (variantnode !== undefined) {
			VariantID = xml.getElementsByTagName('VariantID')[0].firstChild.data
		}
		if (document.getElementById('VariantPrice_' + VariantID)) {
			document.getElementById('VariantPrice_' + VariantID).innerHTML = NewPrice;
		}
	}
}

function getShipping() {
	//this is called on dropdown change
	//reset form if shipping quote exists
	if (adnsf$('#AjaxShippingQuote').html().length > 0) {
		adnsf$('#AjaxShippingQuote').html("");
		ajaxShippingFormReset(false, false, true);
	}
	adnsf$('#AjaxShippingQuote').hide();
	adnsf$('#AjaxShippingLoader').hide();
	adnsf$('#AjaxShippingError').hide();


	var VariantID = adnsf$('input[id^=VariantID]').val();
	var Quantity = adnsf$('input[id^=Quantity]').val();

	if (Quantity === undefined || VariantID === undefined) {
		return;
	}
	if (Quantity.length === 0) {
		Quantity = '1';
	}
	var Country = '';
	if (document.getElementById('Country').length > 0) {
		Country = document.getElementById('Country').options[document.getElementById('Country').selectedIndex].value;
	}
	else {
		Country = document.getElementById('Country').value;
	}
	var State = '';
	if (document.getElementById('State').length > 0) {
		State = document.getElementById('State').options[document.getElementById('State').selectedIndex].value;
	}
	else {
		State = document.getElementById('State').value;
	}
	var PostalCode = '';
	PostalCode = adnsf$('#PostalCode').val();

	var validationError = '';
	if (Country.length < 1) {
		validationError = 'country';
	}
	if (State.length < 1) {
		validationError = 'state';
	}
	if (PostalCode.length < 5) {
		validationError = 'postal';
	}
	if (Quantity < 1) {
		validationError = 'qty';
	}

	if (validationError.length > 0) {
		Cookies.erase('countrycookie');
		Cookies.erase('statecookie');
		Cookies.erase('postalcookie');
		Error(validationError);
	} else {
		Cookies.create('countrycookie', Country, 99);
		Cookies.create('statecookie', State, 99);
		Cookies.create('postalcookie', PostalCode, 99);
		var url = "ajaxShipping.aspx?VariantID=" + VariantID + "&Quantity=" + Quantity + "&Country=" + escape(Country) + "&State=" + escape(State) + "&PostalCode=" + escape(PostalCode);
		makeHttpRequest(url, undefined, 'shipping');
		adnsf$('#AjaxShippingError').hide();
	}
}


function getPricing(ProductID, VariantID) {
	if (ProductID === undefined || VariantID === undefined) {
		return;
	}

	var ChosenSize = "";
	var ChosenSizeList = document.getElementById('AddToCartForm_' + ProductID + '_' + VariantID).Size;
	if (ChosenSizeList !== undefined) {
		ChosenSize = ChosenSizeList.options[ChosenSizeList.selectedIndex].text;
	}

	var ChosenColor = "";
	var ChosenColorList = document.getElementById('AddToCartForm_' + ProductID + '_' + VariantID).Color
	if (ChosenColorList !== undefined) {
		ChosenColor = ChosenColorList.options[ChosenColorList.selectedIndex].text;
	}

	var url = "ajaxPricing.aspx?ProductID=" + ProductID + "&VariantID=" + VariantID + "&size=" + escape(ChosenSize) + "&color=" + escape(ChosenColor);

	makeHttpRequest(url, undefined, 'pricing');
}


function Error(type) {
	adnsf$('#AjaxShippingQuote').html("");
	if (type === 'country') {
		adnsf$('#AjaxShippingError').html("Select A Country").show();
	}
	if (type === 'state') {
		adnsf$('#AjaxShippingError').html("Select A State").show();
	}
	if (type === 'postal') {
		adnsf$('#AjaxShippingError').html("Enter Postal Code").show();
	}
	if (type === 'qty') {
		adnsf$('#AjaxShippingError').html("Enter A Quantity").show();
	}
}

var Cookies = {
	init: function () {
		var allCookies = document.cookie.split('; ');
		for (var i = 0; i < allCookies.length; i++) {
			var cookiePair = allCookies[i].split('=');
			this[cookiePair[0]] = cookiePair[1];
		}
	},
	create: function (name, value, days) {
		var expires = "";
		if (days) {
			var date = new Date();
			date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
			expires = "; expires=" + date.toGMTString();
		}
		document.cookie = name + "=" + value + expires + "; path=/";
		this[name] = value;
	},
	erase: function (name) {
		this.create(name, '', -1);
		this[name] = undefined;
	}
};
Cookies.init();

window.onload = function readCookies() {
	if (!document.getElementById) return false;
	var countrycookie = Cookies['countrycookie'];
	var statecookie = Cookies['statecookie'];
	var postalcookie = Cookies['postalcookie'];
	if (countrycookie) {
		if (statecookie) {
			if (postalcookie) {
				if (document.getElementById('Country') !== null) {
					document.getElementById('Country').value = Cookies['countrycookie'];
					if (document.getElementById('State') !== null) {
						document.getElementById('State').value = Cookies['statecookie'];
						if (document.getElementById('PostalCode') !== null) {
							document.getElementById('PostalCode').value = Cookies['postalcookie'];
							if (document.getElementById('VariantID') !== null) {
								if (document.getElementById('Quantity') !== null) {
									getShipping();
								}
							}
						}
					}
				}
			}
		}
	}
}