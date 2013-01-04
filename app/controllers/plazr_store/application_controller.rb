module PlazrStore
  class ApplicationController < ActionController::Base

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

  protected

    def namespace
      controller_name_segments = params[:controller].split('/')
      controller_name_segments.pop
      controller_namespace = controller_name_segments.join('/').camelize
    end

  end
end
