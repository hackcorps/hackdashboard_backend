class Milestone < ActiveRecord::Base
  belongs_to :organization
  after_initialize :init


  validates :name, presence: true, format: { with: /\A(([a-zA-Z]+-?)+(\s?\d*(\s|\z))*)+\z/}, length: { in: 2..100 }
  validates :data_started, presence: true
  validates :due_date, presence: true
  validates :organization, presence: true
  validates :percent_complete, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  def init
    self.percent_complete  ||= 0.0
    self.data_started ||= DateTime.now
  end
end
