(function ($) {
	$.fn.boxit = function () {

		function positionCenter(element) {
			var windowWidth = $(window).width();
			var windowHeight = $(window).height();
			var elementWidth = $(element).width();
			var elementHeight = $(element).height();
			var leftPosition = (windowWidth / 2) - (elementWidth / 2);
			var topPosition = (windowHeight / 2) - (elementHeight / 2);

			$(element).css({ top: topPosition, left: leftPosition });
		}

		var modal = this;

		modal.open = function() {
			modal.before('<div class="boxit-overlay"></div>');
			modal.show();
			positionCenter(modal);
		};

		modal.close = function () {
			modal.prev('.boxit-overlay').hide();
			modal.hide();
		};

		$(window).resize(function () {
			positionCenter(modal);
		});

		return modal;
	};
}(adnsf$));