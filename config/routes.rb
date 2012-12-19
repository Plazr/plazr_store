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

  get 'index' => 'pages#index'
	root to: 'pages#index'


  namespace :admin do
    resources :brands
    resources :discount_types
    resources :pages
    resources :products do
       resources :variants
    end
    resources :properties
    resources :prototypes
    resources :shipment_conditions
    resources :variant_categories
    resources :variant_properties do
      resources :variant_property_values
    end
  end

  resources :products, :only => [:index, :show]

  mount PlazrAuth::Engine => '/'
end
