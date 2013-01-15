module PlazrStore
  class Admin::LogosController < Admin::ApplicationController
    
    def new
      @logo = Multimedium.new
    end

    def create
      @logo = Multimedium.new params[:multimedium]
      @logo.class_type = "logo"

      if @logo.save
        redirect_to root_path, :notice => 'Logo was successfully created.'
      else
        render :new
      end
    end

    def edit
      @logo = Multimedium.find(params[:id])
    end

    def update
      @logo = Multimedium.find params[:id]

      if @logo.update_attributes(params[:multimedium])
        redirect_to root_path, :notice => 'Logo was successfully updated.'
      else
        render :edit 
      end
    end

  end
end