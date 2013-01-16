$(document).ready(function() {
	var ThumbItem = function(elem, span) {
		this.elem = elem;
		this.span = span;
		this.update = function() {
			spanWidth = $(this.span).width() - 30;
			$(this.elem).height(spanWidth);
		}
	}
	thumbItem = new ThumbItem(".thumb-item-image", ".span3");
	thumbItem.update();

	// featured = new ThumbItem("#featured .featured-image", ".span5");
	// featured.update();

	$(window).resize(function() {
		thumbItem.update();
	});
});
