Rails.application.routes.draw do

  mount PlazrStore::Engine => "/"
  root :to => "plazr_store/pages#index"

end
