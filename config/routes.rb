PlazrStore::Engine.routes.draw do

	namespace :mockup do
		get 'pages/index' => 'pages#index'
		root to: 'pages#index'
	end

	root to: 'mockup/pages#index'

end
