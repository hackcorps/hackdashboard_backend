class Api::V1::ApiController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session

    # do not use CSRF for CORS options
    skip_before_filter :verify_authenticity_token, :only => [:options]

    # http://www.tsheffler.com/blog/?p=428
    before_filter :cors_preflight_check
    after_filter :cors_set_access_control_headers

    def options
      # dummy action, OPTIONS should be caught by cors_preflight_check
    end

    protected

    # For all responses in this controller, return the CORS access control headers.

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, DELETE, PUT, PATCH'
      headers['Access-Control-Max-Age'] = "1728000"
    end

    # If this is a preflight OPTIONS request, then short-circuit the
    # request, return only the necessary headers and return an empty
    # text/plain.

    def cors_preflight_check
      if request.method == 'OPTIONS'
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, DELETE, PUT, PATCH'
        headers['Access-Control-Allow-Headers'] = '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token'
        headers['Access-Control-Max-Age'] = '1728000'
        render :text => '', :content_type => 'text/plain'
      end
    end
end
