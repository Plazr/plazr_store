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
  end

  resources :products, :only => [:index, :show]

  scope '/pages' do
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
  match "receipt" => "orders#receipt", :as => :receipt
  scope '/orders' do
    match "/" => "orders#history", :as => :orders_history
    match '/:id' => 'orders#show', :as => :order, :via => :get
  end

  mount PlazrAuth::Engine => '/'
end
