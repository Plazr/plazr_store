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

  namespace :admin do
    resources :brands
    resources :discount_types
    resources :products do
       resources :variants
    end
    # resources :variants
    resources :properties
    resources :prototypes
    resources :shipment_conditions
    resources :variant_categories
    resources :variant_properties do
      resources :variant_property_values
    end
    resources :pages
  end

  mount PlazrAuth::Engine => '/'
end
