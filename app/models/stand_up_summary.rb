class StandUpSummary < ActiveRecord::Base
  belongs_to :organization
  has_many :stand_ups

  before_create :update_daily_stand_up
  validates :text, presence: true, length: {in: 2..1000 }
  validates :noted_date, presence: true
  validates :organization, presence: true
  validate :organization_stand_up_summary_by_day, on: [ :create ], :unless => lambda { self.noted_date.nil? }

  def update_daily_stand_up
    self.stand_ups = StandUp.where("noted_at = ?", self.noted_date)
  end

  private

  def organization_stand_up_summary_by_day
    if self.organization.stand_up_summaries.where(:noted_date => self.noted_date).count >= 1
      errors.add(:daily_limit, "Exceeds daily limit creating stand-up summary")
    end
  end

end
