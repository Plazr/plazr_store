PlazrStore::Engine.routes.draw do
  namespace :admin do
    resources :brands
    resources :discount_types
    resources :products
    resources :properties
    resources :prototypes
    resources :shipment_conditions
    resources :variant_categories
    resources :variant_properties
  end

  mount PlazrAuth::Engine => '/'
end
