PlazrStore::Engine.routes.draw do

	namespace :mockup do
		get 'pages/index' => 'pages#index'
	end

	root :to => 'pages/index'

end
