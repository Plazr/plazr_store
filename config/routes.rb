PlazrStore::Engine.routes.draw do
  namespace :admin do
    resources :brands
    resources :discount_types
    resources :products do
       resources :variants
    end
    # resources :variants
    resources :properties
    resources :prototypes
    resources :shipment_conditions
    resources :variant_categories
    resources :variant_properties do
      resources :variant_property_values
    end
    resources :pages
  end

  # carts controller
  scope '/cart' do
    match '/' => 'cart#show', :as => :cart, :via => :get
    match 'add/:id'    => 'cart#add',    :as => :cart_add,    :via => :post
    match 'remove/:id' => 'cart#remove', :as => :cart_remove, :via => :delete
  end

  mount PlazrAuth::Engine => '/'
end
