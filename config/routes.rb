PlazrStore::Engine.routes.draw do
  namespace :admin do
    resources :brands
    resources :discount_types
    resources :prototypes
  end

  mount PlazrAuth::Engine => '/'
end
