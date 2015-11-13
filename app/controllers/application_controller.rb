class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
	rescue_from JWT::DecodeError, with: :unauthenticated
	rescue_from JWT::ExpiredSignature, with: :unauthenticated

	attr_reader :current_user

	private

  def authenticate_user_from_token!
		@current_user ||= AuthenticationService.authenticate_user(verify_jwt_token)
	end

	def verify_jwt_token
		request.headers['Authorization'].present? ? request.headers['Authorization'].split(' ').last : ''
	end

	def record_not_found
		render json: {}, status: 404
	end

	def unauthenticated
		render json: {}, status: 401
	end
end
