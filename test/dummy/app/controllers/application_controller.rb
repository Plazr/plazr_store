class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :get_categories
  before_filter :get_pages
  before_filter :get_banner
  before_filter :get_logo
  before_filter :get_cart_price
  before_filter :get_colors

  def get_colors
    c = PlazrStore::TemplateCustomization.all
    @colors = Hash.new
    c.each {|color| @colors[color.id_name] = color.value }
  end

  def get_cart_price
    @cart_price = 0
    @cart_price = current_user.cart.total_price unless current_user.nil?
  end

  def get_categories
    @categories = PlazrStore::ProductCategory.all
  end

  def get_pages
    @pages = PlazrStore::Page.all
  end

  def get_categories
    @categories = PlazrStore::ProductCategory.all
  end

  def get_banner
    @banner = PlazrStore::Multimedium.get_banner
  end

  def get_logo
    @logo = PlazrStore::Multimedium.logo
  end

end
