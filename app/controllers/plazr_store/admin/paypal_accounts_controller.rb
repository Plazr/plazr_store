module PlazrStore
  
  #path = File.expand_path '../../../../..',__FILE__
	#APP_CONFIG = YAML.load_file(path + '/config/config.yml')
  
  class Admin::PaypalAccountsController < ApplicationController
    
    def show
      @paypal_account = PlazrAuth::PaypalAccount.find params[:id]
    end
    
    def new
      #enviar como parametro o id da store
      @paypal_account = PlazrAuth::PaypalAccount.new(:store_id => STORE['store_id'])
    end
    
    def create
      @paypal_account = PlazrAuth::PaypalAccount.new(params[:paypal_account])
      if @paypal_account.save
        redirect_to admin_paypal_account_path(@paypal_account)
      else 
       redirect_to new_admin_paypal_account_path
      end
    end
    
    def index
      @paypal_account = PlazrAuth::PaypalAccount.find_by_store_id(STORE['store_id'])
    end
    
    def edit
      @paypal_account = PlazrAuth::PaypalAccount.find params[:id]
    end
    
    def update
      @paypal_account = PlazrAuth::PaypalAccount.find params[:id]
      @paypal_account.update_attributes(params[:paypal_account])
      redirect_to admin_paypal_accounts_path
    end
  end
end
