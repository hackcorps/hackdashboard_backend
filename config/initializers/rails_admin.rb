require Rails.root.join('lib', 'rails_admin', 'impersonate_user.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::ImpersonateUser)

RailsAdmin.config do |config|
  #config.authenticate_with do
   # warden.authenticate! scope: :user
  #end
  #config.current_user_method(&:current_user)
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

	config.authenticate_with do
    warden.authenticate! scope: :admin
	end

  config.current_user_method(&:current_admin)

	config.authorize_with do
		redirect_to main_app.root_path unless current_admin.is_admin?
  end

  config.model User do
      create do
        field :email
        field :role, :enum do
          enum { User::ROLES }
        end
      end
  end


  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.actions do
   # collection :new do     # subclass Base. Accessible at /admin/<model_name>/my_collection_action
    #end
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    impersonate_user              # custom
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end


end
