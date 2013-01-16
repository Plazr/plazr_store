$(document).ready(function() {
	var ThumbItem = function(elem) {
		this.elem = elem;
		this.update = function() {
			spanWidth = $('.span3').width() - 30;
			$(this.elem).height(spanWidth);
		}
	}
	thumbItem = new ThumbItem(".thumb-item-image");
	thumbItem.update();

	$(window).resize(function() {
		thumbItem.update();
	});
});
