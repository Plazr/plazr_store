module PlazrStore
  class Admin::ApplicationController < ApplicationController

    before_filter :check_admin

    protected

      def check_admin
        #unless can? :admin, :store
        #  flash[:error] = 'You don\'t have permission to access this'
        #  redirect_to root_path
        #end
        true
      end

  end
end