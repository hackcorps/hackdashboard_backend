class UserMailer < ApplicationMailer
  def invitation(email,invite_token)
    @email = email
    @invite_token = invite_token
    mail(to: @email, subject: 'Invite')
  end
  def notification_user(user,project)
    @user = user
    @project = project
    mail(to: @user.email, subject: 'Added to project')
  end
end
