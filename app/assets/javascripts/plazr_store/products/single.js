$(function(){

	var $crosslink, $navthumb;
	var curclicked = 0;

	theInterval = function(cur){

		if( typeof cur != 'undefined' )
			curclicked = cur;

		$crosslink.removeClass("active-thumb");
		$navthumb.eq(curclicked).parent().addClass("active-thumb");
		$(".stripNav ul li a").eq(curclicked).trigger('click');
	};

	$("#main-photo-slider").codaSlider();

	$navthumb = $(".nav-thumb");
	$crosslink = $(".cross-link");

	$navthumb
	.click(function() {
		var $this = $(this);
		theInterval($this.parent().attr('href').slice(1) - 1);
		return false;
	});

	theInterval();
});