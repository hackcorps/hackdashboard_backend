class UserMailer < ApplicationMailer
  def invitation(email,invite_token)
    @email = email
    @invite_token = invite_token
    mail(to: @email, subject: 'Invite')
  end
end
