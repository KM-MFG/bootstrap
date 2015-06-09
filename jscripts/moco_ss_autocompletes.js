

/*
//-------------------------------------------------------------------------------------------------------------------
// ================================================= DESCRIPTION ====================================================
//-------------------------------------------------------------------------------------------------------------------
//

This JavaScript file supports Moco Smart Search Autocomplete. Any input field can be used, the ID of which is assigned
to the variable sInputFieldId for use throughout.

When page is loaded a call is made to Moco Smart Search for a default list of items. 

When user first clicks search input field, a default search results list is displayed, the one called when page first loaded.

As user inputs letters into the search input field, search result requests are sent to Moco Smart Search server, 
returned and displayed in the Moco Smart Search Autocomplete search results panel.

When the search input field losses focus, the search results panel fades out.

------------------------------------------------------------------------------------- FUNCTIONS: ---------------------



$( document ).ready						// set up events and call for initial list
LocateSearchButton()					// locate the search button based on id identifier(s) and get a reference to
LocateInputField()						// locate the search input field based on id identifier(s) and get a reference to
CallServerForDefaultResults()			// calls server for default results - the results displayed with user first gains focus of input field without anything in the field
CallServerForSearchResults()			// calls server for search results - usually each time a letter is input into the search input field
CallServerForItemImages()				// calls server for images to display - usually called when mouse over items in search results panel
SearchField_Focus_Handler()				// handler for focus event of search input field
SearchField_KeyUp_Handler()				// handler for blur event of search input field
DisplayResultList()						// handler for key up event of search input field
ListItemMouseoverEventHandler()			// display result list in search results panel
ListItemMouseoutEventHandler()			// mouse over event for list items displayed in search result panel
DisplayImages()							// mouse out event for list items displayed in search result panel
DisplaySearchPanel()					// display images in search results panel
DisplayBrand()							// display search panel
closeSrchPanel()						// display branding in search results panel
clearListAndImages()					// close search results panel


// =================================================== TODO =========================================================
//

TO DO: option to control number of images returned
TO DO: separate no result result panel close from blur close. Currently when no results returned and close on blur is true, panel closes. 
TO DO: add on/off switch variable


//
//-------------------------------------------------------------------------------------------------------------------
// ============================================== END: DESCRIPTION ==================================================
//-------------------------------------------------------------------------------------------------------------------
*/


//-------------------------------------------------------------------------------------------------------------------
// ================================================= PROPERTIES =====================================================
//				 
//-------------------------------------------------------------------------------------------------------------------
//

var mocoSmartSearchAutoComplete_On = true;

var mocoSmartSearchAutocomplete_DebugOn = true;

// INPUT FIELD
var sInputFieldId = ""; 									// input field used by user for search inputting
var sInputFldIdIncludes = "";
var sInputFldIdEndsWith = "SearchBox";
var sInputFldHtmlTag = "input";
var jqSrchInpFldString;
var jqRefToSearchInpFld; 									// reference to search input field


// SEARCH BUTTON
var searchButtonId = ""; 									// button used by search control to submit search request
var searchButtonIdIncludes = "";
var searchButtonIdEndsWith = "SearchButton";
var searchButtonHtmlTag = "input";
var jqSearchBtnString;
var jqRefToSearchBtn; 										// reference to search button




var objDefJson; 											// default list that displays when item has focus with nothing in search field
var aryDefLst;

//var objMstJson											// object containing all data, key is property name
var aryDefLst; 												// array of objects containing default items to display
var aryDefImg;												// array of image objects currently displayed

var aryCurLst; 												// array of objects containing default items to display
var aryCurImg; 												// array of image objects currently displayed

var aryDisplayedList;										// array of objects currently displayed in search results panel
var aryDisplayedImgs; 										// array of objects containing image info for currently displayed images in search results panel

var sRsltOffset_x = 3;										// horizontal position offset of result panel
var sRsltOffset_y = 0;										// vertical position offset of result panel
var sRsltMinWidth = 400;									// minimum width of search result panel
var sRsltMinHeight = 170;									// minimum height of search result panel
var sRsltAutoSize = false;									// auto size search results panel true/false
var jqRefToElemIdRsltsPnlSzsTo;								// reference to the element that moco smart search autocomplete will size to
var sRsltMaxDspCnt = 4; 									// max number of items displayed in search result panel
var sRsltAlign = "left";									// align search results panel on left/right ("left"/"right") of search input field 
var imgClass = "img-thumbnail img-responsive entity-product-image grid-item-image";  // set the class on the images
var pnlBckGrnd = "#ffffff";                                 // the css background color of the panel when there is a result
var emptyPnlBckGrnd = "#fffff";                             // the css background color of the results panel when there is no result

var sRsltBrandDsp = true;									// branding display on/off (true/false)
var sRsltBrandText = "moco.smart.search.autocomplete"; 		// branding text
var sRsltBrandUrl = "http://www.morrisonconsulting.com/software/aspdotnetstorefront---smart-search.aspx";	// branding url link
var sRsltBrandPosOffset_x = 10;								// branding horizontal offset 
var sRsltBrandPosOffset_y = 0; 								// branding vertical offset 

var maxListItemLength = 25;								    // maximum length of an item, at which point it is truncated and ellipses are added
var imgLabelTextLength = 14;

var sRsltCloseOnBlur = true;								// close search results panel when search field focus lost

var sAjaxUrl = "/ssAutoComplete.aspx";						// URL used to make AJAX calls to server for search results
var sAjaxTimeoutMs = 10000; 								// timeout dur in milliseconds

var WaitingForSearchResults = false; 						// flag indicating still waiting for search results to return from server
var WaitingForImages = false; 								// flag indicating still waiting for image results to return from server


var arwIndxPos = -1;										// index position in array of displayed item that just fired mouse over event, in search results panel
var lastLstItmNm; 											// last list item name (label) that previously fired mouse over event, in search results panel
var curLstItmNm; 											// current list item name (label) that fired mouse over event, in search results panel

var keyDelayIntv;                                           // key delay interval flag indicating call to server for images is okay
var keyDelayPauseMs = 50;                                  // key delay lag maximum milliseconds, is the max pause between keystrokes in search input field
var keyDelayLstIntv = true;                                 // 
var keyDelayTmr;



//
//-------------------------------------------------------------------------------------------------------------------
// =============================================== END: PROPERTIES ==================================================
//-------------------------------------------------------------------------------------------------------------------



// make set up calls and assign event handlers initial list
$( document ).ready( function () {

	// if MoCo Smart Search AutoComplete is turned off, exit setup
	if ( !mocoSmartSearchAutoComplete_On ) {
		return;
	}

	// check body of page to see if moco smart search autocomplete panel is there, if not insert it
	CheckForSearchResultsPanel();

	// locate search button and search input field, getting references or them
	LocateSearchButton();
	LocateInputField();

	// turn off autocomplete for search input field, to prevent input field drop down from obscuring moco smart search autocomplete results panel
	if ( jqRefToSearchInpFld ) {
		jqRefToSearchInpFld.attr( "autocomplete", "off" );
	}

	// assign reference of object the moco smart search autocomplete results panel will position/size to
	jqRefToElemIdRsltsPnlSzsTo = jqRefToSearchInpFld;

	// assign event handlers to input field
	jqRefToSearchInpFld.keyup( SearchField_KeyUp_Handler )
					   .focus( SearchField_Focus_Handler )
					   .blur( SearchField_Blur_Handler );

	// call server and load default results
    //CallServerForDefaultResults("default", true);

	$( window ).resize( winResize );

} );


function CheckForSearchResultsPanel() {

	if ( $( "#srchResContainer" ).length == 0 ) {
		$( "body" ).append( "<div id='srchResContainer' style='display:none;'><div id='srchRes'></div><div id='imgs'></div><div id='brand'>moco.smart.search.auto.complete</div></div>" );
	}
}


// locate the search button based on id identifier(s) and get a reference to
function LocateSearchButton() {

	if ( searchButtonId && searchButtonId.length > 0 ) {
		// make sure ID is prefixed with "#"
		jqSearchBtnString = ( ( searchButtonId.indexOf( "#" ) > -1 ) ? searchButtonId : "#" + searchButtonId );

	} else if ( searchButtonIdIncludes && searchButtonIdIncludes.length > 0 ) {
		// id includes
		jqSearchBtnString = searchButtonHtmlTag + "[id*=" + searchButtonIdIncludes + "]";

	} else if ( searchButtonIdEndsWith && searchButtonIdEndsWith.length > 0 ) {
		// id ends with
		jqSearchBtnString = searchButtonHtmlTag + "[id$='" + searchButtonIdEndsWith + "']";
	}

	// try to find control
	jqRefToSearchBtn = $( jqSearchBtnString );

	if ( jqRefToSearchBtn.length == 0 ) {

		jqRefToSearchBtn = undefined;

		if ( mocoSmartSearchAutocomplete_DebugOn ) {
			alert( "Moco Smart Search Autocomplete unable to locate Search Button" );
		}
	}
}

// locate the search input field based on id identifier(s) and get a reference to
function LocateInputField() {

	if ( sInputFieldId && sInputFieldId.length > 0 ) {
		// make sure ID is prefixed with "#"
		jqSrchInpFldString = ( ( sInputFieldId.indexOf( "#" ) > -1 ) ? sInputFieldId : "#" + sInputFieldId );

	} else if ( sInputFldIdIncludes && sInputFldIdIncludes.length > 0 ) {
		// id includes
		jqSrchInpFldString = sInputFldHtmlTag + "[id*=" + sInputFldIdIncludes + "]";

	} else if ( searchButtonIdEndsWith && searchButtonIdEndsWith.length > 0 ) {
		// id ends with
		jqSrchInpFldString = sInputFldHtmlTag + "[id$='" + sInputFldIdEndsWith + "']";
	}


	// try to find control
	jqRefToSearchInpFld = $( jqSrchInpFldString );


	if ( jqRefToSearchInpFld.length == 0 ) {

		jqRefToSearchInpFld = undefined;

		if ( mocoSmartSearchAutocomplete_DebugOn ) {
			alert( "Moco Smart Search Autocomplete unable to locate Search Input Field" );
		}
	}
}

// calls server for default results - the results displayed with user first gains focus of input field without anything in the field
function CallServerForDefaultResults( sTxt, def ) {

	$.ajax( {
		type: "GET",
		url: sAjaxUrl,
		data: { s: "DEFAULT" },
		cache: false,
		dataType: "html",
		timeout: sAjaxTimeoutMs
	} )
	.done( function ( rspTxt ) {

		try {

			if ( !rspTxt || $.trim( rspTxt ).length == 0 ) {
				return;
			}

			var tmpObj = JSON.parse( rspTxt );

			if ( !tmpObj || tmpObj.length == 0 ) {
				return;
			}

			aryDefLst = tmpObj[0];
			aryDefImg = tmpObj[1];

			CallServerForItemImages( aryDefLst[0].name, aryDefLst[0].entity )

		} catch ( err ) {
			// ignore error, but catch it to prevent client-side JavaScript failure
		}

	} )
	.fail( function ( jqXHR, textStatus, errorThrown ) {
		closeSrchPanel( true );
	} )
	.always( function () {
	} );
}


// calls server for search results - usually each time a letter is input into the search input field
function CallServerForSearchResults( sTxt, def ) {

	WaitingForSearchResults = true;

	$.ajax( {
		type: "GET",
		url: sAjaxUrl,
		data: { s: sTxt },
		cache: false,
		dataType: "html",
		timeout: sAjaxTimeoutMs
	} )
	.done( function ( rspTxt ) {

		try {

			if ( !rspTxt || $.trim( rspTxt ).length == 0 ) {
				return;
			}

			var tmpObj = JSON.parse( rspTxt );

			if ( !tmpObj || tmpObj.length == 0 ) {
				return;
			}

			aryCurLst = tmpObj[0];
			aryCurImg = tmpObj[1];

		    DisplayResultList(aryCurLst, jqRefToSearchInpFld.val());

		    if (aryCurLst && aryCurLst.length > 0) {
		        clearInterval(keyDelayIntv);
		        keyDelayIntv = setInterval(CallServerForItemImages, keyDelayPauseMs, aryCurLst[0].name, aryCurLst[0].entity);
			    //CallServerForItemImages(aryCurLst[0].name, aryCurLst[0].entity);
			} else {
				// clear displayed images
				DisplayImages( undefined, true );
			}

		} catch ( err ) {
			// ignore error, but catch it to prevent client-side JavaScript failure
		}

	} )
	.fail( function ( jqXHR, textStatus, errorThrown ) {
		closeSrchPanel( true );
	} )
	.always( function () {
		WaitingForSearchResults = false;
	} );
}

// calls server for images to display - usually called when mouse over items in search results panel
function CallServerForItemImages( prdName, ent ) {

    if (!keyDelayLstIntv) {
        return;
    } else {
        clearInterval(this.keyDelayIntv);
    }

	WaitingForImages = true;

	$.ajax( {
		type: "GET",
		url: sAjaxUrl,
		data: { imgName: prdName, e: ent },
		cache: false,
		dataType: "html",
		timeout: sAjaxTimeoutMs
	} )
	.done( function ( rspTxt ) {

		try {

			// convert returned data to array of objects containing image info
			var aryObj = JSON.parse( rspTxt );

			// display images
			DisplayImages( aryObj, true );

		} catch (err) {
		    // clear image display
		    DisplayImages(undefined, true);
		}

	} )
	.fail(function (jqXHR, textStatus, errorThrown) {
	    // clear image display
		DisplayImages(undefined, true);
	})
	.always( function () {
		WaitingForImages = false;
	} );
}


// handler for focus event of search input field
function SearchField_Focus_Handler() {

	// if search input field has content, display what is in the displayed arrays
	if ( $.trim( jqRefToSearchInpFld.val() ).length > 0 ) {

	    DisplayResultList(aryDisplayedList, $.trim(jqRefToSearchInpFld.val()));

		if ( aryDisplayedImgs != null && aryDisplayedImgs.length > 0 && aryDisplayedList != null & aryDisplayedList.length > 0 ) {
		    CallServerForItemImages(aryDisplayedList[0].name, aryDisplayedList[0].entity);
		} else {
			DisplayImages( aryDisplayedImgs, true );
		}


	} else if ( aryDefLst && aryDefLst.length > 0 ) {

		// if default arrays exist, display list/images from those
	    DisplayResultList(aryDefLst, "");

		if ( aryDisplayedImgs != null && aryDisplayedImgs.length > 0 ) {
		    CallServerForItemImages(aryDefLst[0].name, aryDefLst[0].entity);
		} else {
			DisplayImages( aryDisplayedImgs, true );
		}

	} else {
		closeSrchPanel();
	}
}

// handler for blur event of search input field
function SearchField_Blur_Handler() {
	closeSrchPanel();
}




function SetLstIntv() {
    keyDelayLstIntv = true;
}


// handler for key up event of search input field
function SearchField_KeyUp_Handler(event) {

    keyDelayLstIntv = false;
    clearTimeout(keyDelayTmr);
    keyDelayTmr = setTimeout(SetLstIntv, keyDelayPauseMs);

    var inpFld = jqRefToSearchInpFld;

	// handle left/right/enter keys
	if ( event.keyCode == 38 || event.keyCode == 40 || event.keyCode == 13 ) {

	    // TO DO: if moving before beginning or after end, go to end/beginning respectively

	    keyDelayLstIntv = true;

		if ( event.keyCode == 38 ) {

			arwIndxPos = ( arwIndxPos - 1 < 0 ) ? aryDisplayedList.length - 1 : arwIndxPos - 1;

		} else if ( event.keyCode == 40 ) {

			arwIndxPos = ( arwIndxPos + 1 > aryDisplayedList.length - 1 ) ? 0 : arwIndxPos + 1;

		} else if ( event.keyCode == 13 ) {
		    return;
		}

	    lastLstItmNm = curLstItmNm;
		curLstItmNm = aryDisplayedList[arwIndxPos].name;

		$( "#srchRes li[id='" + lastLstItmNm + "']" ).attr( "class", "lstItmNormal" );
		$( "#srchRes li[id='" + curLstItmNm + "']" ).attr( "class", "lstItmOver" );

		// display in search field
		inpFld.val( curLstItmNm );

		CallServerForItemImages( curLstItmNm, $( "#srchRes li[id='" + curLstItmNm + "']" ).attr( "ent" ) );

		return;
	}

	$( "#PressEnterToSearch" ).html( "press enter to search <span style='font-weight:bold;'>" + jqRefToSearchInpFld.val() + "</span>..." );

	if ($.trim(inpFld.val()).length == 0) {
	    DisplayResultList(undefined, "");
	    DisplayImages(undefined, true);
	    //CallServerForItemImages(aryDefLst[0].name, aryDefLst[0].entity);
	} else {
		CallServerForSearchResults( inpFld.val() );
	}
}


function EncodeTxt( txt ) {
	return $( '<div/>' ).text( txt ).html();
}


// display result list in search results panel
function DisplayResultList( ary, txtHighlighted ) {

	// clear displayed items array 
	aryDisplayedList = new Array();

	var len = ( txtHighlighted ) ? txtHighlighted.length : 0;

	$( "#srchRes" ).empty();

	$( "#srchRes" ).append( "<ul class='lstCnt'>" );

    if (ary && ary.length > 0) {
        var cnt = 0;
        $("#srchResContainer").css({ backgroundColor: pnlBckGrnd });
        for (e in ary) {

            if (++cnt > sRsltMaxDspCnt) {
                break;
            }

            aryDisplayedList.push(ary[e]);

            // truncate label if necessary
            var nm = ((ary[e].name.length < maxListItemLength) ? ary[e].name : ary[e].name.substr(0, maxListItemLength - 3) + "...");

            // display list item
            if (len > 0) {
                $("#srchRes").append("<li id='" + ary[e].name + "' class='lstItmNormal' ent='" + ary[e].entity + "' idx='" + e + "'>" + FormatTitleCase(nm).replace(new RegExp("\\b" + txtHighlighted, "gi"), "<span class='bld'>" + TxtHighlight(ary[e].name, txtHighlighted) + "</span>") + "</li>");

            } else {
                $("#srchRes").append("<li id='" + ary[e].name + "' class='lstItmNormal' ent='" + ary[e].entity + "' idx='" + e + "'>" + FormatTitleCase(nm) + "</li>");
            }
        }
    } else {
        $("#srchResContainer").css({ backgroundColor: emptyPnlBckGrnd });
    }

	$( "#srchRes" ).append( "</ul>" );

	$( "#srchRes" ).append( "<div id='PressEnterToSearch' class='pressEnterToSearch'>press enter to search <span style='font-style:italic; font-weight:bold;'>" + jqRefToSearchInpFld.val() + "</span>...</div>" );

	$( "#srchRes li" ).mouseover( ListItemMouseoverEventHandler )
					  .mouseout( ListItemMouseoutEventHandler )
					  .click( ListItemClickEventHandler );

	DisplaySearchPanel();
}


// return highlighted text in proper case: i.e. the same case as in label
function TxtHighlight(txt, highlightTxt) {
    var s = "";
    for (var i = 0; i < highlightTxt.length; i++) {
        s += (i == 0) ? highlightTxt.substr(i, 1).toUpperCase() : highlightTxt.substr(i, 1);
    }
    return s;
}


function FormatTitleCase(txt) {
    var aTxt = txt.split(" ");
    var s = "";
    for (var i = 0; i < aTxt.length; i++) {
        s += aTxt[i].substr(0, 1).toUpperCase() + aTxt[i].substr(1).toLowerCase() + " ";
    }
    return $.trim(s);
}


// click event for list items displayed in search result panel
function ListItemClickEventHandler() {

	var thisItem = $(this);

	// place item value in search field
	if ( jqRefToSearchInpFld ) {
		jqRefToSearchInpFld.val( thisItem.attr( "id" ) );
	}

	// click search button
	if ( jqRefToSearchBtn ) {
		jqRefToSearchBtn.click();
	}
}


// mouse over event for list items displayed in search result panel
function ListItemMouseoverEventHandler() {

	arwIndxPos = parseInt( $( this ).attr( "idx" ) );

	$( "#srchRes li[id='" + curLstItmNm + "']" ).attr( "class", "lstItmNormal" );

	lastLstItmNm = curLstItmNm;

    curLstItmNm = $(this).attr("id");

	$( this ).attr( "class", "lstItmOver" );


	if ( WaitingForImages ) {
		return;
	}

	CallServerForItemImages( this.id, $(this).attr("ent") );

	return;
}

// mouse out event for list items displayed in search result panel
function ListItemMouseoutEventHandler() {
	$( this ).attr( "class", "lstItmNormal" );
}


var aryDisplayedImgs = new Array();


// display images in search results panel
function DisplayImages( imgAry, dspImgsOnly ) {

	// clear image panel
	$( "#imgs" ).empty();

    // if array has content, display images
	if ( dspImgsOnly && imgAry && imgAry.length > 0 ) {
		for ( var i = 0; i < imgAry.length; i++ ) {

			if ( imgAry[i] != undefined ) {

				aryDisplayedImgs.push( imgAry[i] );

				$("#imgs").append("<div class='imgcon'><div><a href='" + imgAry[i].url + "' title='" + imgAry[i].label + "'><img src='" + imgAry[i].image + "' class='"+ imgClass + "'/></div><div class='imgCpt'>" + ((imgAry[i].label && imgAry[i].label.length > imgLabelTextLength) ? imgAry[i].label.substr(0, imgLabelTextLength) + "..." : ((imgAry[i].label) ? imgAry[i].label : "")) + "</a></div></div>");
			}
		}
	}

    // if displaying default results, display default images
	if ( $.trim( $(sInputFieldId).val() ).length == 0 ) {

		if ( imgAry && imgAry.length > 0 && objDefJson && objDefJson[imgAry[0]] && objDefJson[imgAry[0]].images && objDefJson[imgAry[0]].images.length > 0 ) {

			// display images
			for ( var i = 0; i < 4; i++ ) {

				if ( imgAry[i] != undefined ) {

					aryDisplayedImgs.push( imgAry[i] );

					$( "#imgs" ).append( "<div class='imgcon'><div><a href='" + objDefJson[imgAry[0]].images[i].url + "' title='" + objDefJson[imgAry[0]].images[i].desc + "'><img src='" + objDefJson[imgAry[0]].images[i].image + "'/></div><div class='imgCpt'>" + objDefJson[imgAry[0]].images[i].label + "</a></div></div>" );
				}
			}
		}

		DisplayBrand();

		return;
	}


	DisplayBrand();
}


// display search panel
function DisplaySearchPanel() {

	if ( $( "#srchResContainer:visible" ).length == 0 ) {

		searchPanelPos();

		$( "#srchResContainer" ).fadeIn( 'fast', DisplayBrand );
	}

}


function winResize() {
	if ( $( "#srchResContainer:visible" ).length > 0 ) {
		searchPanelPos();
	}
}


function searchPanelPos() {

	var pos = jqRefToSearchInpFld.offset();
	var posHeight = jqRefToElemIdRsltsPnlSzsTo.outerHeight();
	var posWidth = jqRefToElemIdRsltsPnlSzsTo.outerWidth();
	if ($("#srchResContainer").outerWidth() < posWidth) {
	    $("#srchResContainer").css({width: (posWidth + "px")});
	}
	  
	var fnlOffset = ((sRsltAlign.toLowerCase() === 'left') ? ((pos.left + jqRefToSearchInpFld.outerWidth() - $("#srchResContainer").outerWidth()) + "px") : (pos.left + sRsltOffset_x) + "px");
	var hThs = $("#srchResContainer").height();

	$("#srchResContainer").css({
        top: (pos.top + posHeight + sRsltOffset_y) + "px",
        left: fnlOffset
    });
}


// display branding in search results panel
function DisplayBrand() {

	if ( sRsltBrandDsp ) {

		var hRs = $( "#srchResContainer" ).height();
		var wRs = $( "#srchResContainer" ).width();

		var hBrn = $( "#brand" ).height();
		var wBrn = $( "#brand" ).width();

		$( "#brand" ).css( {
			position: "absolute",
			top: ( hRs - hBrn + sRsltBrandPosOffset_y ) + "px",
			left: ( wRs - wBrn + sRsltBrandPosOffset_x ) + "px"
		} ).html( "<a href='" + sRsltBrandUrl + "' target='_blank' class='brandLnk' >" + sRsltBrandText + "</a>" ).fadeIn( 'slow' );
	}
}


// close search results panel
function closeSrchPanel(err) {
	if ( sRsltCloseOnBlur || err ) {
		$( "#srchResContainer" ).fadeOut( 'fast', clearListAndImages );
	}
}


// clear displayed list and images
function clearListAndImages() {
	$( "#srchRes" ).empty();
	$( "#imgs" ).empty();
}

