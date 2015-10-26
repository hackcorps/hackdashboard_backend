class Organization < ActiveRecord::Base
  has_many :users_organizations, dependent: :delete_all
  has_many :users, through: :users_organizations
  validates :name, presence: true, length: { in: 2..50 }

  def self.organization_names
     %w(Admin Customer TeamMember ProjectManager)
  end
end
