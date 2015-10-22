class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.find_by(invite_token: params[:invite_token])
    if(@user)
      if @user.update(full_name: params[:full_name], password: params[:password],
          password_confirmation: params[:password_confirmation], invite_token: '' )
        sign_in(@user)
        render json: { success: true, user: { email: @user.email, role: @user.role, auth_token: AuthenticationService.new(@user).auth_token } }, status: 201
      else
        render json: { success: false, errors: @user.errors.full_messages }, status: 422
      end
    else
      render json: { status: false, errors: [{ invite_token: 'Invite token not founded' }]}
    end
  end

  def update
    super
  end

end