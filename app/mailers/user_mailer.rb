class UserMailer < ApplicationMailer
  def invitation(email,invite_token,organization)
    @email = email
    @invite_token = invite_token
    @organization = organization
    mail(to: @email, subject: 'Invite')
  end
  def notification_user(user,organization)
    @user = user
    @organization = organization
    mail(to: @user.email, subject: 'Added to project')
  end
end
