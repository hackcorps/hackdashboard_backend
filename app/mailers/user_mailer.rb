class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invitation.subject
  #
  def invitation(email,invite_token)
    @email = email
    @invite_token = invite_token
    mail( to: @email, subject: 'Invite')
  end
end
