module PlazrStore
  # Controller for intaracting with the general functionality of the application
  class ApplicationController < ActionController::Base

  before_filter :get_pages

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to plazr_auth_url, :alert => exception.message
  end

  layout 'application'

  #def resource
  #  @resource ||= 

  def index
  end

  # Get the permissions of the current user
  def current_ability
    @current_ability ||= Ability.new(current_user, namespace)
  end

  # Get all the pages of the store (Products, Contacts, etc)
  def get_pages
    @pages = Page.all
  end

  protected

    def namespace
      controller_name_segments = params[:controller].split('/')
      controller_name_segments.pop
      controller_namespace = controller_name_segments.join('/').camelize
    end

  end
end
