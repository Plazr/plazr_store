module PlazrStore
  module ProductHelper

		def rating_to_stars(num)
			images = (0...5).collect do |x|
				if x < num
					image_tag 'plazr_store/rate/star-full.png', :class => 'rating'
				else
					image_tag 'plazr_store/rate/star-empty.png', :class => 'rating'
				end
			end
			raw(images.join(" "))
		end
  end
end
