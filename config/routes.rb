Rails.application.routes.draw do
	root 'home#index'

	devise_for :admin
	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

	resources :organizations

	devise_for :users,:path_prefix => 'api/v1', controllers: { sessions: 'api/v1/users/sessions' }

  namespace :api do
		namespace :v1 do
     	 resource :users
    end
  end

	get 'api' => 'home#api'

	#get 'users' => 'users#new', as: 'users_register'
	#post 'users' => 'users#create'
end
