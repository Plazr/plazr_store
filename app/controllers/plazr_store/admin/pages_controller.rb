module PlazrStore
  # Controller for the admin to interact with the page model
  class Admin::PagesController < Admin::ApplicationController

    # Get the page with the given id
    def show
      @page = Page.find(params[:id])
    end

    # Get all the pages available
    def index
      @pages = Page.all
    end

    # Create a new page with the given information
    def create
      @page = Page.new(params[:page])

      if @page.save
        redirect_to admin_page_path(@page), :notice => 'Page was successfully created.'
      else
        render :new
      end
    end

    # Create a new empty page
    def new
      @page = Page.new
    end

    # Get a page with the given id to display in the edit form
    def edit
      @page = Page.find params[:id]
    end

    # Update the page of the given id with the given information
    def update
      @page = Page.find(params[:id])

      if @page.update_attributes(params[:page])
        redirect_to admin_page_path(@page), :notice => 'Page was successfully updated.'
      else
        render :edit
      end
    end

    # Delete a page with the given id
    def destroy
      @page = Page.find(params[:id])
      @page.destroy
      redirect_to admin_pages_path
    end
  end
end
