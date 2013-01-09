//= require jquery
//= require jquery_ujs
//= require bootstrap/datepicker/core.js
//= require bootstrap/datepicker/locales/bootstrap-datepicker.pt.js
//= require bootstrap/timepicker.js

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
	$('.timepicker').each(function(){
		$(this).timepicker({
			minuteStep: 1,
			showMeridian: false,
			defaultTime: 'value'
		});
		$(this).focus(function(){
			$(this).siblings('span.add-on').each(function(){
				$(this).trigger('click');
			});
		});
		$(this).blur(function(){
			$(this).siblings('span.add-on').each(function(){
				$('html').trigger('click');
			});
		});
	});
});