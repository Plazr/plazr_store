module PlazrStore
  class ApplicationController < ActionController::Base

  before_filter :get_categories
  before_filter :get_pages
  before_filter :get_banner
  before_filter :get_logo

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to plazr_auth_url, :alert => exception.message
  end

  layout 'application'

  #def resource
  #  @resource ||=

  def index
  end


  def current_ability
    @current_ability ||= Ability.new(current_user, namespace)
  end

  def get_pages
    @pages = Page.all
  end

  def get_categories
    @categories = ProductCategory.all
  end

  def get_banner
    @banner = Multimedium.banner
  end

  def get_logo
    @logo = Multimedium.logo
  end

  protected

    def namespace
      controller_name_segments = params[:controller].split('/')
      controller_name_segments.pop
      controller_namespace = controller_name_segments.join('/').camelize
    end

  end
end
