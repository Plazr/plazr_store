function product_photo_resize(){
	$('div.photo').each(function(){
		var d = $(this);
		d.height(d.width());
	});
}

$(product_photo_resize);


$('article.product').each(function(){
	$(this).selected = true;
});

$('article.product').click(function(){
	var a = $(this);
	console.log(a.selected);
});

$(window).resize(product_photo_resize)