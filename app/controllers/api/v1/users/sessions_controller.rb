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
		@user = User.new(user_params)

		if User.find_by_email!(@user.email) && @user.valid?
			sign_in(user)
			render json: { user: { email: @user.email, role: @user.role, auth_token: AuthenticationService.new(@user).auth_token } }
		else
			render json: { errors: @user.errors.full_messages }
		end
	end

	def destroy


		user = AuthenticationService.authenticate_user(params[:auth_token])
		binding.pry
		sign_out(user)
		binding.pry
		render json: { success: true }, status: 200
	end

	private
	def user_params
		params.require(:user).permit(:email, :password)
	end
end