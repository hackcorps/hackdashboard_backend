Rails.application.routes.draw do

  namespace :api do
  namespace :v1 do
    get 'stand_up_summary/create'
    end
  end

  namespace :api do
  namespace :v1 do
    get 'stand_up_summary/update'
    end
  end

	root 'home#index'

	devise_for :admin
	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

	resources :organizations

	devise_for :users,:path_prefix => 'api/v1', controllers: {
                                                sessions: 'api/v1/users/sessions',
                                                registrations: 'api/v1/users/registrations',
																								passwords: 'api/v1/users/passwords'
                                            }

	get 'api' => 'home#api'

	namespace :api do
		namespace :v1 do
      resources :milestones
			resources :stand_ups
      resources :stand_up_summaries
    end
  end



end
