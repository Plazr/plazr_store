module PlazrStore
  class Admin::LogosController < Admin::ApplicationController

    def new
      @new_logo = Multimedium.new
    end

    def create
      @new_logo = Multimedium.new params[:multimedium]

      if @new_logo.save
        redirect_to root_path, :notice => 'Logo was successfully created.'
      else
        render :new
      end
    end

    def edit
      @new_logo = Multimedium.find(params[:id])
    end

    def update
      @new_logo = Multimedium.find params[:id]

      if @new_logo.update_attributes(params[:multimedium])
        redirect_to root_path, :notice => 'Logo was successfully updated.'
      else
        render :edit
      end
    end

  end
end