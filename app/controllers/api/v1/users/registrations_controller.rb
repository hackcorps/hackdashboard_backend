class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.find_by(invite_token: params[:user][:invite_token])
    if(@user)
      if @user.update(full_name: params[:user][:full_name], password: params[:user][:password],
          password_confirmation: params[:user][:password_confirmation], invite_token: '' )
      render json: { status: true, user: @user }, status: 422
      else
        render json: { status: false, errors: @user.errors.full_messages }, status: 422
      end
    else
      render json: { status: false, errors: [{ invite_token: 'Invite token not founded' }]}
    end
  end

  def update
    super
  end

  private
  def user_params
    params.require(:user).permit(:full_name, :password, :password_confirmation)
  end


end 