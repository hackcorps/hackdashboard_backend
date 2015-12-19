class Organization < ActiveRecord::Base
  has_many :milestones, dependent: :destroy
  has_many :users_organizations, dependent: :delete_all
  has_many :users, through: :users_organizations
  has_many :stand_ups, through: :stand_up_summaries , dependent: :destroy
  has_many :stand_up_summaries,  dependent: :destroy

  validates :name, presence: true, length: { in: 2..50 }, uniqueness: { case_sensitive: true }
end
