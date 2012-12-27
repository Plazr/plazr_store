module PlazrStore
  class ApplicationController < ActionController::Base

    layout 'application'

    def index
    end


    private

      def current_ability
        logger.info namespace
        Ability.new(current_user, namespace)
      end

      def namespace
        controller_name_segments = params[:controller].split('/')
        controller_name_segments.pop
        controller_namespace = controller_name_segments.join('/').camelize
      end

  end
end
