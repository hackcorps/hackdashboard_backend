class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.find_by(invite_token: params[:invite_token])
    if(@user)
      if @user.update(full_name: params[:full_name], password: params[:password],
          password_confirmation: params[:password_confirmation], invite_token: '' )
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


end 