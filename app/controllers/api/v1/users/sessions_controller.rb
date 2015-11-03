class Api::V1::Users::SessionsController < ApplicationController
  before_action :authenticate_user_from_token!, only: :destroy

	swagger_controller :sessions, "Sessions"

	# Disable CSRF protection
  skip_before_action :verify_authenticity_token

	# Be sure to enable JSON.
	respond_to :html, :json

	swagger_api :create do
		summary 'Create a user session.'
    param :form, 'user[email]', :string, :required, 'Email address'
		param :form, 'user[password]', :string, :required, 'Password'
		response :bad_request
	end

	swagger_api :destroy do
		summary 'Destroy a user session.'
		param :form, :auth_token, :string, :required, 'Authentication token'
		response :no_content
  end

	def create
		return failer unless User.new(user_params).valid?
		user = User.find_by_email(params[:user][:email])
		user && user.valid_password?(params[:user][:password]) ? sign_in_user(user) : failer
	end

	def destroy
		AuthenticationService.expired(@current_user)
		render json: {}, status: 200
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

	def sign_in_user(resource)
		render json: {
										user: {
														email: resource.email,
														role: resource.role,
														auth_token: AuthenticationService.new(resource).auth_token
										}
		}
	end

	def failer
		render json: { error: I18n.t('devise.failure.invalid') }, status: 400
	end
end