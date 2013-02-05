$(document).ready(function() {

	$("#filter").click(getValues);

	$("#reset").click(resetValues);

	function resetValues(){
		$('.clearfix #search').val('');
		$('input[name="min_price"]').val('');
		$('input[name="max_price"]').val('');

		$('#category').prop("selectedIndex", 0);
		$('#brand').prop("selectedIndex", 0);
		$('#price').prop("selectedIndex", 0);

	}

	function getValues(){
		var search = $('.clearfix #search').val();
		var min_price = $('input[name="min_price"]').val();
		var max_price = $('input[name="max_price"]').val();

		var category = $('#category option:selected').val();
		var brand = $('#brand option:selected').val();
		var price = $('#price option:selected').val();

		var newURL = window.location.protocol + "://" + window.location.host + "/"


		window.location = "/search?utf8=✓&search=" + search + "&min_price=" + min_price + "&max_price=" + max_price + "&brand=" + brand + "&price=" + price + "&category=" + category;
	}
});
