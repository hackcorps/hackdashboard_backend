class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :build_params, only: :create

  respond_to :html, :json

  def create
    @user = User.find_by!(invite_token: registration_params[:invite_token])
    return expired unless @user.invite_token_period_valid?(2)

    if @user.update(build_params)
      render json: { success: true, user: { email: @user.email, role: @user.role, auth_token: AuthenticationService.new(@user).auth_token } }, status: 201
    else
      render json: { success: false, errors: @user.errors.full_messages }, status: 422
    end
  end

  private

  def registration_params
    require(:user).permit(:full_name, :password, :password_confirmation, :invite_token)
  end

  def build_params
    {
      full_name: registration_params[:full_name],
      password: registration_params[:password],
      password_confirmation: registration_params[:password_confirmation],
      invite_token: nil,
      invite_token_sent_at: nil
    }
  end

  def expired
     render json: {errors: ['Your invite expired.']}, status: 419
  end
end