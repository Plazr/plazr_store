PlazrStore::Engine.routes.draw do
  namespace :admin do
    resources :brands
    resources :discount_types
    resources :products
    resources :properties
    resources :prototypes
    resources :shipment_conditions
    resources :variant_categories
    resources :variants
    resources :variant_properties
    resources :pages
  end

  mount PlazrAuth::Engine => '/'
end
