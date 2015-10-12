#class Api::V1::UsersController < ActionController::Base
class UsersController < ActionController::Base
  def new
    @user = User.new()
    @user.invite_token= params[:invite_token]
  end
  def create
    invitation = Invitation.find_by(invite_token: params[:user][:invite_token])
    if(invitation)
      @user = User.new(email: invitation.email, password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], role: 'Admin' )
      if @user.save
        redirect_to root_path
      else
        render json: { status: false, errors: @user.errors.full_messages }, status: 422
      end
    end
  end
end