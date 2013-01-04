PlazrStore::Engine.routes.draw do

  root :to => 'application#index'

  namespace :admin do
    resources :brands
    resources :discount_types
    resources :pages
    resources :product_categories
    resources :products do
      resources :product_properties, :only => [:index, :create, :destroy]
      resources :variants
      resources :multimedia
    end
    resources :properties
    resources :prototypes
    resources :shipment_conditions
    resources :variant_properties do
      resources :variant_property_values
    end
    resources :paypal_accounts
  end

  resources :products, :only => [:index, :show]
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
  match 'express_checkout' => 'paypal_express#checkout', :as => :express_checkout
  match 'review' => 'orders#review', :as => :review
  match 'checkout' => 'orders#new', :as => :checkout, :via => :get
  match 'checkout' => 'orders#create', :as => :checkout, :via => :post
  match "receipt" => "orders#receipt", :as => :receipt
  match "/orders" => "orders#history", :as => :orders_history
  match 'paypal_express_purchase' => 'paypal_express#purchase', :as => :paypal_express_purchase
  

  mount PlazrAuth::Engine => '/'
end
