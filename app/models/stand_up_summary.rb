class StandUpSummary < ActiveRecord::Base
  belongs_to :organization
  has_many :stand_ups

  validates :text, presence: true, length: {in: 2..1000 }
  validates :noted_date, presence: true
  validates :organization, presence: true

end
