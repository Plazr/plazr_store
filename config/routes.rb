PlazrStore::Engine.routes.draw do

	namespace :mockup do
		get 'index' => 'pages#index'
		get 'single' => 'pages#single'
		get 'about' => 'pages#about'
		root to: 'pages#index'
	end

	root to: 'mockup/pages#index'

end
