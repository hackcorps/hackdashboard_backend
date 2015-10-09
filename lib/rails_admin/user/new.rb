module RailsAdmin
  module Config
    module Actions
      class New < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post] # NEW / CREATE
        end


        register_instance_option :link_icon do
          'icon-eye-open'
        end

        # override the controller logic by adding something like this to the class
        register_instance_option :controller do
          Proc.new do
            # Note: This is dummy code. The thing to note is that we aren't
            # rendering a view, just redirecting after taking an action on @object, which
            # will be the user instance in this case.
            @object.impersonate
            redirect_to back_or_index
          end
        end
      end
    end
  end
end