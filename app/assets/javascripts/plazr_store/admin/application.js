//= require jquery
//= require jquery_ujs
//= require bootstrap/datepicker/core.js
//= require bootstrap/datepicker/locales/bootstrap-datepicker.pt.js

// make all photo containers square
function product_photo_resize(){
	$('div.photo').each(function(){
		var d = $(this);
		d.height(d.width());
	});
}

$(product_photo_resize);
$(window).resize(product_photo_resize);
$(function(){
	$('.datepicker').each(function(){
		$(this).datepicker();
	});
});