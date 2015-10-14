#class Api::V1::UsersController < ActionController::Base
class UsersController < ActionController::Base
  def new
    @user = User.new()
    @user.invite_token= params[:invite_token]
  end
  def create
    @user = User.find_by(invite_token: params[:user][:invite_token])
    if(@user)
      if @user.update(full_name: params[:user][:full_name], password: params[:user][:password],
                      password_confirmation: params[:user][:password_confirmation], invite_token: '' )
        redirect_to root_path
      else
        render json: { status: false, errors: @user.errors.full_messages }, status: 422
      end
    else
      render json: { status: false, errors: [{ invite_token: 'Invite token not founded' }]}
    end
  end

  private
  def user_params
    params.require(:user).permit(:full_name, :password, :password_confirmation)
  end
end