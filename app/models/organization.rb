class Organization < ActiveRecord::Base
  validates :name, presence: true, length: { in: 2..50 }
end
