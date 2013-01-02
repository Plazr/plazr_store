Rails.application.routes.draw do

  root :to => "plazr_store/pages#index"

  mount PlazrStore::Engine => "/"

end
