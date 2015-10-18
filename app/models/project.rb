class Project < ActiveRecord::Base
  belongs_to :organization
  has_many :projects_users, dependent: :delete_all
  has_many :users, through: :projects_users
end
