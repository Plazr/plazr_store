# encoding: utf-8
class PlazrStore::Admin::ApplicationController < PlazrStore::ApplicationController

  before_filter :check_admin
  before_filter :get_location

  def index
  end

  protected

    def check_admin
      if cannot? :manage, :store
        redirect_to root_path, :alert => "You don't have permission to access this"
      end
    end

    def get_location
      @section = params[:controller].split('/').last
      @view = params[:action]
    end
end
