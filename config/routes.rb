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

  mount PlazrAuth::Engine => '/'
end
