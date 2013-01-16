module PlazrStore
  # Controller to interact with the general functionality of the application
  class Admin::ApplicationController < ApplicationController

    before_filter :check_admin

    layout 'admin/application'

    def index
    end

    protected

      # Check if the current user is an admin
      def check_admin
        if cannot? :manage, :store
          redirect_to root_path, :alert => "You don't have permission to access this"
        end
      end

  end
end
