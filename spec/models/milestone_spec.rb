require 'rails_helper'

RSpec.describe Milestone, type: :model do
    let(:organization)  { FactoryGirl.create(:organization) }
    let(:milestone) { Milestone.new( name: 'Task 1',
                                    due_date: Faker::Date.between(Date.today, 2.days.from_now),
                                    organization_id: organization.id)}
    it { should belong_to :organization }
    it { should  have_many :stand_ups }

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

    describe 'set default value ' do
      it ' should percent_complete' do
        expect(milestone.percent_complete).not_to be_nil
        milestone.save!
        expect(milestone.percent_complete).not_to be_nil
      end
      it ' should data_started' do
        expect(milestone.data_started).not_to be_nil
        milestone.save!
        expect(milestone.data_started).not_to be_nil
      end
    end

end