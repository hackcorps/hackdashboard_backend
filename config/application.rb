require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hack
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  #  config.action_dispatch.default_headers = {
   #     'Access-Control-Allow-Origin' => '*',
    #    'Access-Control-Request-Method' => '*'
    #}
    #config.middleware.use Rack::Cors do
     # allow do
      #  origins '*'
       # resource '*',
        #         :headers => ['Origin', 'Accept', 'Content-Type',  'Overwrite', 'Destination', 'Depth', 'User-Agent', 'X-File-Size', 'X-Requested-With', 'If-Modified-Since', 'X-File-Name', 'Cache-Control'],
         #        :methods => [:options, :get, :post, :put, :delete ]
      #end
    #end
    #config.middleware.insert_before 0, "Rack::Cors" do
     # allow do
      #  origins '*'
       # resource '*',
        #         :headers => ['Origin', 'Accept', 'Content-Type'],
         #        :methods => [:get, :post, :delete, :put, :patch, :options, :head],
          #
          #       :max_age => 0
      #end
    #end



    #config.middleware.use "Rack::Cors"  do
     # allow do
      #  origins '*'
       # resource '*',
        #         :headers => :any,
         #        :methods => [:get, :post, :delete, :put, :patch, :options, :head]
      #end
    #end


  end
end