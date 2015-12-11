class StandUp < ActiveRecord::Base
  belongs_to :user
  belongs_to :milestone
  belongs_to :stand_up_summary

  validates :update_text, presence: true, length: { in: 2..1000 }
  validates :noted_at, presence: true
  validates :user, presence: true
  validates :milestone, presence: true
  validate :user_stand_up_by_day, on: [ :create ], :unless => lambda { self.noted_at.nil?  }

  before_save :calculate_milestone_cost

  def calculate_milestone_cost
    cost = self.milestone.cost + (self.user.cost_per_month*8)/168
    self.milestone.update(cost: cost)
  end

  private
  def user_stand_up_by_day
    if self.user.stand_ups.where(:noted_at => self.noted_at).count >= 1
      errors.add(:daily_limit, "Exceeds daily limit creating a stand-up")
    end
  end
end
