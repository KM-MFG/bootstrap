//header help search
$('.js-help-button').click(function (event) {
	var helpBox = $('.js-help-box');
	if(helpBox.val().length > 0) {
		var helpUrl = 'http://help.aspdotnetstorefront.com/manual/95/default.aspx?pageid=_search_&searchtext=' + helpBox.val();
		window.open(helpUrl);
	}
	else {
		helpBox.focus();
	}
	event.preventDefault();
});

$('.js-help-box').keyup(function (event) {
	if(event.keyCode == 13) {
		$('.js-help-button').click();
	}
});
