class Api::V1::Users::SessionsController < Devise::SessionsController
	swagger_controller :sessions, "Sessions"

	swagger_api :create do
		summary 'Create a user session.'
    param :form, 'user[email]', :string, :required, 'Email address'
		param :form, 'user[password]', :string, :required, 'Password'
		response :unauthorized
    response :not_found
	end

	swagger_api :destroy do
		summary 'Destroy a user session.'
		param :form, :auth_token, :string, :required, 'Authentication token'
		response :unauthorized
	end

	def create
		return failer unless User.new(user_params).valid?
		user = User.find_by_email(params[:user][:email])
		user && user.valid_password?(params[:user][:password]) ? sign_in_user(user) : failer
	end

	def destroy
		user = AuthenticationService.authenticate_user(params[:auth_token])
		sign_out(user)

		render json: {}, status: 200
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

	def sign_in_user(resource)
		sign_in(resource)

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