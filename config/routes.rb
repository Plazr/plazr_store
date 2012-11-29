PlazrStore::Engine.routes.draw do
  namespace :admin do
    resources :brands
    resources :discount_types
    resources :prototypes
    resources :properties
    resources :variant_properties
  end

  mount PlazrAuth::Engine => '/'
end
