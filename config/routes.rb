PlazrStore::Engine.routes.draw do

  get 'index' => 'pages#index'
  # root to: 'pages#index'



  root :to => 'pages#index'

  # mount RedactorRails::Engine => '/redactor_rails'

  namespace :admin do
    root :to => 'pages#index'
    resources :banners, :only => [:new, :create, :edit, :update]
    resources :brands
    resources :discount_types
    resources :orders, :except => [:new, :create, :edit, :update, :destroy] do
      put 'pay', :on => :member
      match 'ship/:cart_variant_id' => 'orders#ship', :as => :ship_product, :via => :put
    end
    resources :logos, :only => [:new, :create, :edit, :update]
    resources :pages
    resources :product_categories
    resources :products do
      resources :product_properties, :only => [:index, :create, :destroy]
      resources :variants
      resources :multimedia
    end
    resources :promotional_codes
    resources :promotions
    resources :properties
    resources :prototypes
    resources :shipment_conditions
    resources :template_customizations
    resources :variant_properties do
      resources :variant_property_values
    end
    resources :paypal_accounts
    match 'customization' => 'customizations#show', :as => :customization, :via => :get, :controller => 'customizations'
  end

  resources :products, :only => [:index, :show]

  #pages
  scope '/pages' do
    match 'index' => 'pages#index', :via => :get
    match '/:slug' => 'pages#show', :as => :page, :via => :get, :controller => "pages"
  end

  # search controller
  scope '/search' do
    match '/' => 'search#search', :as => :search, :via => :get, :controller => "search"
  end

  # carts controller
  scope '/cart' do
    match '/' => 'cart#show', :as => :cart, :via => :get
    match 'add/:id'    => 'cart#add',    :as => :cart_add,    :via => :post
    match 'remove/:id' => 'cart#remove', :as => :cart_remove, :via => :delete
  end

  scope '/wishlist' do
    match '/' => 'wishlist#show', :as => :wishlist, :via => :get
    match 'add/:id'    => 'wishlist#add',    :as => :wishlist_add,    :via => :post
    match 'remove/:id' => 'wishlist#remove', :as => :wishlist_remove, :via => :delete
  end

  # orders controller
  match 'checkout' => 'orders#new', :as => :checkout, :via => :get
  match 'checkout' => 'orders#create', :as => :checkout, :via => :post
  match 'express_checkout' => 'paypal_express#checkout', :as => :express_checkout
  match 'paypal_express_purchase' => 'paypal_express#purchase', :as => :paypal_express_purchase
  match "receipt" => "orders#receipt", :as => :receipt
  match 'review' => 'orders#review', :as => :review
  scope '/orders' do
    match "/" => "orders#history", :as => :orders_history
    match '/:id' => 'orders#show', :as => :order, :via => :get
    match '/:id/feedbacks/:product_id' => 'feedback_products#new', :as => :new_feedback_product, :via => :get
    match '/:id/feedbacks/:product_id' => 'feedback_products#create', :as => :feedback_product, :via => :post
  end


  mount PlazrAuth::Engine => '/'
end
