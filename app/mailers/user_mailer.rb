class UserMailer < ApplicationMailer
  def invitation(email,invite_token,organization)
    @email = email
    @invite_token = invite_token
    @organization = organization
    mail(to: @email, subject: 'Invite')
  end
  def notification_user(email, full_name, organization)
    @full_name = full_name
    @organization = organization
    mail(to: email, subject: 'Added to a organization')
  end
end
