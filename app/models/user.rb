class User < ActiveRecord::Base
	has_many :users_organizations, dependent: :delete_all
	has_many :organizations, through: :users_organizations

	before_create :send_invite, :unless => lambda { self.role == 'Admin' }

	ROLES = %w(Admin Customer TeamMember ProjectManager)

	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable

	validates :email, format: Devise.email_regexp
	validates :password, presence: true, allow_blank: false, on: :create, :unless => lambda { self.full_name.blank? }
	validates_confirmation_of :password, on: :create
	validates :organizations, presence: true, on: :create, :unless => lambda { self.role == 'Admin' }

	def is_admin?
		self.role == 'Admin'
	end

	private

	def send_invite
		UserMailer.invitation(self.email, self.invite_token,self.organizations.last.name).deliver_now
	end

	def generate_token
	  self.invite_token = loop do
			random_token = SecureRandom.urlsafe_base64(nil, false)
			break random_token unless User.exists?(invite_token: random_token)
		end
	end
end

