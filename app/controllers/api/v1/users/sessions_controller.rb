class Api::V1::Users::SessionsController < Devise::SessionsController

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
		sign_out(current_user)

		render json: { }, status: 200
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end
end