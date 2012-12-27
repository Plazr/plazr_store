module PlazrStore
  class Admin::ApplicationController < ApplicationController

    before_filter :check_admin

    protected

      def check_admin
        flash[:error] = 'You don\'t have permission to access this'
        redirect_to root_path unless can? :admin, :all
      end

  end
end
