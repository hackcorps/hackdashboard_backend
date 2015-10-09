class Organization < ActiveRecord::Base
  has_many :projects
  validates :name, presence: true, length: { in: 2..50 }
end
