PlazrStore::Engine.routes.draw do
  
  mount PlazrAuth::Engine => '/'

  namespace :admin do
    resources :brands
    resources :discount_types
    resources :prototypes
  end
end
