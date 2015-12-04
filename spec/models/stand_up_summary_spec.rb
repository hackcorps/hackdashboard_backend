require 'rails_helper'

RSpec.describe StandUpSummary, type: :model do
  let(:organization)  { FactoryGirl.create(:organization) }

  let(:project_manager) { FactoryGirl.create(:project_manager, organizations:  [ organization ] ) }
  let(:milestone) { Milestone.new( name: 'Task 1',
                                   due_date: Faker::Date.between(Date.today, 2.days.from_now),
                                   organization_id: organization.id)}

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

  context 'when create stand-up summary' do
    it 'associate with its daily stand-up' do
      stand_up_first = FactoryGirl.create(:stand_up, milestone: milestone, user: project_manager)
      stand_up_second = FactoryGirl.create(:stand_up, milestone: milestone, user: project_manager)
      stand_up_summary = FactoryGirl.create(:stand_up_summary, organization_id: organization.id)
      expect(stand_up_summary.stand_ups.count).to eq(2)
    end
  end

end
