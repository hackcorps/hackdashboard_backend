Rails.application.routes.draw do
	root 'home#index'

	devise_for :admin
	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

	resources :organizations

	devise_for :users,:path_prefix => 'api/v1', controllers: { sessions: 'api/v1/users/sessions' }

end
