//= require jquery
//= require jquery_ujs
//= require redactor-rails
//= require plazr_store/products/single
//= require imageSlider/jquery-easing-1.3.pack
//= require imageSlider/jquery-easing-compatibility.1.2.pack
//= require imageSlider/coda-slider.1.1.1.pack
//= require bootstrap/bootstrap.min.js
//= require bootstrap/datepicker/core.js
//= require bootstrap/datepicker/locales/bootstrap-datepicker.pt.js
//= require bootstrap/timepicker.js
//= require_self
//= require plazr_store/topbar
//= require plazr_store/search/search
//= require plazr_store/thumb-item
//= require plazr_store/cart/show
//= require bootstrap-colorpicker

/*********************************************************/
/** Global (reserved) functions
 *
 *  <<NOTE>> Keeping this sorted alphabetically will help
 *         searching through.
 *
 *  [PC, 9 Jan 2013]
 *  square_photo_resize : resize containers to keep a square frame
 */

$(function() {
	// this line is breaking everything else and preventing the datepickers and timepickers from showing up
	$('.topbar-wrapper .dropdown-toggle').dropdown();

	/** Activate datepicker dropdowns
	 *
	 * Usage:
	 *
	 * <div class="input-append datepicker" data-date-format="yyyy-mm-dd">
	 *     <input type="text" readonly />
	 *     <span class="add-on">
	 *         <%= image_tag 'glyphicons/calendar.png', :class => :icon %>
	 *     </a>
	 * </div>
	 */
	$('.datepicker').each(function(){
		$(this).datepicker();
	});



	/** Activate timepicker dropdowns
	 *
	 * Usage:
	 *
	 * <div class="input-append bootstrap-timepicker-component">
	 *     <input type="text" class="timepicker" readonly />
	 *     <span class="add-on">
	 *         <%= image_tag 'glyphicons/clock.png', :class => :icon %>
	 *     </a>
	 * </div>
	 */
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




/**
 * Adds 0 left margin to the first thumbnail on each row that don't get it via CSS rules.
 * Recall the function when the floating of the elements changed.
 */
function fixThumbnailMargins() {
    $('.row-fluid .thumbnails').each(function () {
        var $thumbnails = $(this).children(),
            previousOffsetLeft = $thumbnails.first().offset().left;
        $thumbnails.removeClass('first-in-row');
        $thumbnails.first().addClass('first-in-row');
        $thumbnails.each(function () {
            var $thumbnail = $(this),
                offsetLeft = $thumbnail.offset().left;
            if (offsetLeft < previousOffsetLeft) {
                $thumbnail.addClass('first-in-row');
            }
            previousOffsetLeft = offsetLeft;
        });
    });
};






/** Function to resize the square photo containers.
 *   The container must always be a div (no other tag with class
 * photo will be modified).
 *
 * Usage:
 *
 * <div class="photo" style="background-image:url('path/to/image.ext')"></div>
 */
function square_photo_resize() {
	$('div.photo').each(function(){
		var d = $(this);
		d.height(d.width());
	});
	fixThumbnailMargins();
};
// resize photos when the window is finished loading
$(window).load(square_photo_resize);
// resize photos everytime the window is resized (responsive)
$(window).resize(square_photo_resize);
