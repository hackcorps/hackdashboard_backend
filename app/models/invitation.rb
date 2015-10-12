class Invitation < ActiveRecord::Base
  before_create :send_invite

  def send_invite
    generate_token
    UserMailer.invitation(self.email, self.invite_token).deliver_now
  end

  protected
  def generate_token
    self.invite_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Invitation.exists?(invite_token: random_token)
    end
  end

end
