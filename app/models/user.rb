class User < ActiveRecord::Base
	ROLES = %w(Admin Customer TeamMember ProjectManager)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

	validates :email,  presence: true
	validates :password, presence: true, allow_blank: false, on: :create
	validates :password, confirmation: true
	validates :password_confirmation, presence: true, unless: 'password.nil?'

	attr_accessor :invite_token
	def is_admin?
		self.role == 'Admin'
	end
end
