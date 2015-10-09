Rails.application.routes.draw do
	root 'home#index'

	resources :organizations

  namespace :api do
		namespace :v1 do
			devise_for :users, controllers: { sessions: 'api/v1/users/sessions' }
		end
	end

	devise_for :admins
	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
