PlazrStore::Engine.routes.draw do
  namespace :admin do
    resources :brands
    resources :discount_types
    resources :pages
    resources :products do
       resources :variants
    end
    resources :properties
    resources :prototypes
    resources :shipment_conditions
    resources :variant_categories
    resources :variant_properties do
      resources :variant_property_values
    end
  end

  resources :products, :only => [:index, :show]
  resource :wishlist
  # match 'wishlist' => 'wishlists#show'

  mount PlazrAuth::Engine => '/'
end
