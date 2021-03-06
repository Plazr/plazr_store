
$(document).ready(function() {
	var Navbar = function (elem) {
		this.fixed = 0;
		this.elem = elem;
		this.elemViewTop = $(elem).offset().top;
		this.isNavbarVisible = function() {
			return $(window).scrollTop() < this.elemViewTop;
		}
		this.update = function() {
			if(this.isNavbarVisible() && this.fixed) {
				$(elem).removeClass("fixed");
				this.fixed = 0;
			} else if (!this.fixed && !this.isNavbarVisible()) {
				$(elem).addClass("fixed");
				this.fixed = 1;
			}
		}
	}

	if($(".topbar-wrapper").length) {
		nav = new Navbar(".topbar-wrapper");
		nav.update();

		$(window).scroll(function() {
			nav.update();
		});
	}
});
