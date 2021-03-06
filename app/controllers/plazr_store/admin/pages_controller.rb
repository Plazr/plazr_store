# encoding: utf-8
module PlazrStore
  class Admin::PagesController < Admin::ApplicationController
    def show
      @page = Page.find(params[:id])
    end

    def index
      @pages = Page.all.paginate( page: params['page'], per_page: 10 )
    end

    def create
      @page = Page.new(params[:page])

      if @page.save
        redirect_to admin_page_path(@page), :notice => 'Página criada com sucesso.'
      else
        render :new
      end
    end

    def new
      @page = Page.new
    end

    def edit
      @page = Page.find params[:id]
    end

    def update
      @page = Page.find(params[:id])

      if @page.update_attributes(params[:page])
        redirect_to admin_page_path(@page), :notice => 'Página atualizada com sucesso.'
      else
        render :edit
      end
    end

    def destroy
      @page = Page.find(params[:id])
      @page.destroy
      redirect_to admin_pages_path
    end

    def get_location
      super
      @tab = 'pages'
    end
  end
end
