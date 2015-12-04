class Api::V1::Users::PasswordsController < Devise::PasswordsController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    @user = User.send_reset_password_instructions(params[:user])

    if successfully_sent?(@user)
      render json: { success: true }, status: 200
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  def update
    @user = User.reset_password_by_token(params[:user])

    if @user.errors.empty?
      @user.unlock_access! if unlockable?(@user)
      render json: { status: true }, status: 200
    else
      render json: { status: false, errors: @user.errors.full_messages }
    end
  end
end