class User < ActiveRecord::Base
	has_many :users_organizations, dependent: :delete_all
	has_many :organizations, through: :users_organizations
  has_many :stand_ups

	before_create :send_invite, :unless => :is_admin?

	ROLES = %w(Admin Customer TeamMember ProjectManager)

	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

	validates :email, format: Devise.email_regexp
	validates :password, presence: true, allow_blank: false, on: :create, :unless => lambda { self.full_name.blank? }
	validates_confirmation_of :password, on: :create
	validates :organizations, presence: true, on: :create, unless: :is_admin?
	validates :role, presence: true

	def is_admin?
		self.role == 'Admin'
  end

  def is_team_member?
    self.role == 'TeamMember'
  end

	def invite_token_period_valid?(invite_token_within = 0)
		self.invite_token_sent_at + invite_token_within.days >= DateTime.now
	end

	private

	def send_invite
		generate_token
		UserMailer.invitation(self.email, self.invite_token,self.organizations.last.name).deliver_now
	end

	def generate_token
	  self.invite_token = loop do
			random_token = SecureRandom.urlsafe_base64(nil, false)
			break random_token unless User.exists?(invite_token: random_token)
	  end

		self.invite_token_sent_at = Time.zone.now
	end
end

