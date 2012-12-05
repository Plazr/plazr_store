PlazrStore::Engine.routes.draw do

	namespace :mockup do
		get 'index' => 'pages#index'
		get 'single' => 'pages#single'
		get 'about' => 'pages#about'
		root to: 'pages#index'
		namespace :admin do
			get 'index' => 'pages#index'
		end
		get 'profile' => 'profiles#index'
	end

	root to: 'mockup/pages#index'

end
