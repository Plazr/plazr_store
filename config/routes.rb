PlazrStore::Engine.routes.draw do
  namespace :admin do
    resources :brands
  end
end
