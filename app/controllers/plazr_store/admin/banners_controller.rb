module PlazrStore
  class Admin::BannersController < Admin::ApplicationController
    
    def new
      @banner = Multimedium.new
    end

    def create
      @banner = Multimedium.new params[:multimedium]
      
      if @banner.save
        redirect_to root_path, :notice => 'Banner was successfully created.'
      else
        render :new
      end
    end

    def edit
      @banner = Multimedium.find(params[:id])
    end

    def update
      @banner = Multimedium.find params[:id]

      if @banner.update_attributes(params[:multimedium])
        redirect_to root_path, :notice => 'Banner was successfully updated.'
      else
        render :edit 
      end
    end

  end
end