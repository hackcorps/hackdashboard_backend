class AuthenticationService
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def initialize(user, expiration_time = 7.days.from_now)
    @user = user
    @expiration_time = expiration_time
  end

  def auth_token
    JWT.encode({ exp: expiration_time.to_i, id: user.id }, SECRET_KEY)
  end

  def self.authenticate_user(auth_token)
    decoded, _ = JWT.decode(auth_token, SECRET_KEY)
    User.find(decoded['id'])
  end

  def self.expired(current_user)
    JWT.encode({ exp: 3.day.ago.to_i, id: current_user.id }, SECRET_KEY)
  end

  private

  attr_reader :user, :expiration_time
end
