module PlazrStore
  class Admin::ApplicationController < ApplicationController

    before_filter :check_admin
    before_filter :get_location

    def index
    end

    def get_location
      @section = params[:controller].split('/').last
      @view = params[:action]
    end

    protected

      def check_admin
        if cannot? :manage, :store
          redirect_to root_path, :alert => "You don't have permission to access this"
        end
      end

  end
end
