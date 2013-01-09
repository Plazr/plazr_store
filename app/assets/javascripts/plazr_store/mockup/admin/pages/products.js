function product_photo_resize(){
	$('div.photo').each(function(){
		var d = $(this);
		d.height(d.width());
	});
}

$(product_photo_resize);
$(window).resize(product_photo_resize)

$('article.product').click(function(){
	var article = $(this);
	article.find(':checkbox').each(function(){
		var checkbox = $(this)[0];
		checkbox.checked = !checkbox.checked;
	});
});