class Api::V1::Users::SessionsController < Devise::SessionsController
	swagger_controller :sessions, "Sessions"

	swagger_api :create do
		summary 'Create a user session.'
    param :user, :email, :string, :required, 'Email address'
		param :user, :password, :string, :required, 'Password'
		response :unauthorized
	end

	swagger_api :destroy do
		summary 'Destroy a user session.'
    param :user, :email, :string, :required, 'Email address'
		param :user, :auth_token, :string, :required, 'Authentication token'
		response :unauthorized
	end

	def create
		@user = User.new(user_params)

		if @user.valid? && user = User.find_by_email(@user.email)
			sign_in(user)
			render json: { user: { email: user.email, role: user.role, auth_token: AuthenticationService.new(user).auth_token } }
		else
			render json: { errors: @user.errors.full_messages }
		end
	end

	def destroy
		user = User.find_for_database_authentication(email: params[:user][:email]) #TODO AuthToken
		sign_out(user)

		render json: { }, status: 200
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end
end