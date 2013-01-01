module PlazrStore
  class ApplicationController < ActionController::Base

    layout 'application'

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
