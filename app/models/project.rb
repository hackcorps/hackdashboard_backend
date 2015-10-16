class Project < ActiveRecord::Base
  belongs_to :organization
  has_many :projects_users
  has_many :users, through: :projects_users
  accepts_nested_attributes_for :projects_users, :allow_destroy => true
end
