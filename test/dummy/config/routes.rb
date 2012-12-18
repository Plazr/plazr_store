Rails.application.routes.draw do

  root :to => "plazr_store/application#index"

  mount PlazrStore::Engine => "/"

end
