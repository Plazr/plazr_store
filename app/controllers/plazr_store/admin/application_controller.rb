module PlazrStore
  class Admin::ApplicationController < ApplicationController

    before_filter :check_admin

    def index
    end

    protected

      def check_admin
        if cannot? :manage, :store
          redirect_to root_path, :alert => "You don't have permission to access this"
        end
      end

  end
end
