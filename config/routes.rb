PlazrStore::Engine.routes.draw do
  namespace :admin do
    resources :brands
    resources :discount_types
    resources :products
    resources :properties
    resources :prototypes
    resources :variant_categories
    resources :variant_properties
    resources :pages
  end

  mount PlazrAuth::Engine => '/'
end
