require 'rails_helper'

RSpec.describe StandUpSummary, type: :model do
  it { should belong_to :organization }
  it { should  have_many :stand_ups }

  it { should respond_to(:noted_date) }
  it { should respond_to(:text) }


  describe 'validations' do
    it { should validate_presence_of :text }
    it { should validate_presence_of :noted_date }
    it { should validate_presence_of :organization }
    it { should validate_length_of(:text).is_at_least(2).is_at_most(1000) }
  end
end
