require 'rails_helper'

RSpec.describe Milestone, type: :model do

    it { should belong_to :organization }

    it { should respond_to(:name) }
    it { should respond_to(:data_started) }
    it { should respond_to(:percent_complete) }
    it { should respond_to(:due_date) }
    it { should respond_to(:cost) }

    describe 'validations' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :data_started }
      it { should validate_presence_of :due_date }
      it { should validate_presence_of :organization }
      it { should validate_length_of(:name).is_at_least(2).is_at_most(100) }
      it { should validate_numericality_of(:percent_complete ). is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }
      it { should allow_value("Task 1").for(:name) }
      it { should_not allow_value("1Inv4lid_").for(:name) }
    end


end