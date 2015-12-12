class Api::V1::UsersController < ActionController::Base
  def new
    @user = User.new
    @user.invite_token = params[:invite_token]
  end

  def create
    @user = User.find_by(invite_token: user_params[:invite_token])

    if @user
      if @user.update(build_params)
        render json: { user: @user }, status: 422
      else
        render json: { errors: @user.errors.full_messages }, status: 422
      end
    else
      render json: { errors: { invite_token: 'Invite token not founded' } }, status: 200
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :password, :password_confirmation, :invite_token)
  end

	def build_params
		{
			full_name: user_params[:full_name],
			password: user_params[:password],
      password_confirmation: user_params[:password_confirmation],
			invite_token: ''
		}
	end
end