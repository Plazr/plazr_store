function add_p(params){
		if(parseInt($('#'+params + ' #add_cart_f #amount').val()) > 0){
			$('#'+params + ' #add_cart_f').submit();
			$('#'+params + ' #delete a').click();
		}
	}