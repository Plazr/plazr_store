$(document).ready(function() {

	$("#filters a").click(getValues);

	function getValues(){
		var search = $('.clearfix #search').val();
		var min_price = $('input[name="min_price"]').val();
		var max_price = $('input[name="max_price"]').val();

		var category = $('#cat option:selected').val();
		var brand = $('#brand option:selected').val();
		var price = $('#price option:selected').val();

		var newURL = window.location.protocol + "://" + window.location.host + "/"

		window.location = "/search?utf8=✓&search=" + search + "&cat=" + category + "&min_price=" + min_price + "&max_price=" + max_price + "&brand=" + brand + "&price=" + price;
	}
});