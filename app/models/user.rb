class User < ActiveRecord::Base
	has_many :projects_users, dependent: :delete_all
	has_many :projects, through: :projects_users

	before_create :send_invite

	ROLES = %w(Admin Customer TeamMember ProjectManager)

	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable

	validates :email, presence: true
	validates :email, uniqueness: { case_sensitive: false }
	validates :password, presence: true, allow_blank: false, on: :create, :unless => lambda { self.full_name.blank? }

	def is_admin?
		self.role == 'Admin'
	end

	private

	def send_invite
	  generate_token
	  UserMailer.invitation(self.email, self.invite_token).deliver_now
	end

	def generate_token
	  self.invite_token = loop do
			random_token = SecureRandom.urlsafe_base64(nil, false)
			break random_token unless User.exists?(invite_token: random_token)
		end
	end
end

