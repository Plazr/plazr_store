//= require jquery
//= require jquery_ujs

// make all photo containers square
function product_photo_resize(){
	$('div.photo').each(function(){
		var d = $(this);
		d.height(d.width());
	});
}

$(product_photo_resize);
$(window).resize(product_photo_resize);