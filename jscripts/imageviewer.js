//create and image object to store each image's attributes
function imageInfo(SRC, WIDTH, HEIGHT) {
    this.src = SRC;
    this.width = WIDTH;
    this.height = HEIGHT;
}
function setColor(newColor) {
    
    //don't set the color if the color has no image. This can be done from the color dropdown.
    if (imageSizes['Icon'][newColor][view].src.match("nopicture")) {
        return;
    }

    var usingCloudZoom = false;
    try {
        if (typeof ($('.cloud-zoom').CloudZoom) == 'function') {
            usingCloudZoom = true;
        }
    }
    catch (err){}

    //set the global color
    color = newColor;
    
    //get the medium image
    var image = document.getElementById('productImage');
    //set the src attribute
    if (image) {
        image.src = imageSizes['Medium'][color][view].src;
    }
    

    //get and set the product image zoom link
    var largeImageLink = document.getElementById('largeImageLink');
    if (largeImageLink) {
        largeImageLink.href = imageSizes['Large'][color][view].src;
    }

    //get and set the zoom button link
    var showLargerLink = document.getElementById('showLargerLink');
    if (showLargerLink) {
        showLargerLink.href = imageSizes['Large'][color][view].src;
    }

    //alert(ddlControlId);

    //update the view colors if they're there
    if (hasMultiViewImages == 'true') {
        //get all the images in viewcontrols
        var viewControls = document.getElementById('viewControls');
        if (viewControls) {
            var viewImages = viewControls.getElementsByTagName('img');
        }
        //set their src attributes
        if (viewImages) {
            for (i = 0; i < viewImages.length; i++) {
                viewImages[i].src = imageSizes['Icon'][color][i + 1].src;
                if (usingCloudZoom) {
                    viewImages[i].parentNode.rel = "useZoom: 'largeImageLink', smallImage: '" + imageSizes['Medium'][color][i + 1].src + "'";
                    viewImages[i].parentNode.href = imageSizes['Large'][color][i + 1].src;
                }
            }
        }
    }

    //get the add to cart color dropDown
    var colorSelect = document.getElementById(getDropDownId());

    if (colorSelect) {
        //get the options
        var dropOptions = colorSelect.getElementsByTagName('option');
    }

    //loop through the options to find a match and set that match as the selected option.
    if (dropOptions) {
        for (j = 0; j < dropOptions.length; j++) {
            //get the color from the option's value. It's formatted Color,SkuModifier
            var optionColor = dropOptions[j].value.split(',', 1);
            if (optionColor == color) {
                dropOptions[j].selected = true;
            }
        }
    }
    //re-initialize cloudzoom if its being used.
    if (usingCloudZoom) {
        try{
            $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
        }
        catch(err){}
    }
}
function setView(newView) {

    //set the global view variable
    view = newView;

    //get and set the medium image
    var image = document.getElementById('productImage');
    if (image) {
        image.src = imageSizes['Medium'][color][view].src;
    }


    //get and set the product image zoom link
    var largeImageLink = document.getElementById('largeImageLink');

    if (largeImageLink) {
        largeImageLink.href = imageSizes['Large'][color][view].src;
    }

    //get and set the zoom button link
    var showLargerLink = document.getElementById('showLargerLink');
    if (showLargerLink) {
        showLargerLink.href = imageSizes['Large'][color][view].src;
    }

    //set the view of the colors if their there
    if (hasMultiColorImages == 'true') {
        //get all the color controls images
        var colorControls = document.getElementById('colorControls')
        if (colorControls) {
            var colorImages = colorControls.getElementsByTagName('img');
        }
        //set all the color images' src attributes	
        if (colorImages) {
            for (i = 0; i < colorImages.length; i++) {
                var iconColor = colorImages[i].alt
                colorImages[i].src = imageSizes['Icon'][iconColor][view].src;
            }
        }
    }
}
function popUpLarge() {
    if ((!imageSizes['Large'][color][view].src.match("nopicture")) && (imageSizes['Large'][color][view].src)) {
        window.open('popup.aspx?src=' + imageSizes['Large'][color][view].src, 'LargerImage', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=' + imageSizes['Large'][color][view].width + ',height=' + imageSizes['Large'][color][view].height + ',left=0,top=0');
    }
    else if (defaultLargeImage.src != '') {
        window.open('popup.aspx?src=' + defaultLargeImage.src, 'LargerImage', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=' + defaultLargeImage.width + ',height=' + defaultLargeImage.height + ',left=0,top=0');
    }
    else {
        alert('Image Unavailable')
    }
}

function getDropDownId()
{
    var cbs = [];
    var cbs = $("input:hidden");
    for (var i = 0; i < cbs.length; i++) {
        var ControlId = cbs[i].id;
        if (ControlId.indexOf("ProductID") == 0) {
            var ddlControlId = ControlId.replace("ProductID_", "Color_");
        }
    }
    return ddlControlId;
}