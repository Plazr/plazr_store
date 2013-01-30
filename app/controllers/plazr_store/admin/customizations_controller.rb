module PlazrStore
  class Admin::CustomizationsController < Admin::ApplicationController

    def show
      @banner = Multimedium.banner
      @logo = Multimedium.logo
    end

  end
end