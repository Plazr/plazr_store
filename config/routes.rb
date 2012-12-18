PlazrStore::Engine.routes.draw do

	namespace :mockup do
		get 'index' => 'pages#index'
		get 'single' => 'pages#single'
		get 'about' => 'pages#about'
		get 'search' => 'pages#search'
		root to: 'pages#index'
		namespace :admin do
			get 'index' => 'pages#index'
			get 'products' => 'pages#products'
			get 'create' => 'pages#create'
			root to: 'pages#index'
		end
		get 'profile' => 'profiles#index'
	end

	root to: 'mockup/pages#index'

end
