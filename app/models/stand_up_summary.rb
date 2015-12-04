class StandUpSummary < ActiveRecord::Base
  belongs_to :organization
  has_many :stand_ups
  before_create :update_daily_stand_up
  validates :text, presence: true, length: {in: 2..1000 }
  validates :noted_date, presence: true
  validates :organization, presence: true

  def update_daily_stand_up
    self.stand_ups = StandUp.where("noted_at = ?", self.noted_date)
  end
end
