require 'rails_helper'

RSpec.describe StandUp, type: :model do
    let(:organization)  { FactoryGirl.create(:organization) }
    let(:milestone) { FactoryGirl.create(:milestone, organization: organization ) }
    let(:team_member) { FactoryGirl.create(:team_member, organizations:  [ organization ] ) }

    it { should belong_to :user }
    it { should belong_to :milestone }
    it { should belong_to :stand_up_summary }

    it { should respond_to(:update_text) }
    it { should respond_to(:noted_at) }

    describe 'validations' do
      it { should validate_presence_of :update_text }
      it { should validate_presence_of :noted_at }
      it { should validate_presence_of :milestone }
      it { should validate_presence_of :user }
      it { should validate_length_of(:update_text).is_at_least(2).is_at_most(1000) }
    end

    context 'when create stand-up' do
      it 'calculates cost of milestone' do
        stand_up = FactoryGirl.build(:stand_up, milestone: milestone, user: team_member)
        cost = milestone.cost
        stand_up.save
        expect(stand_up.milestone.cost).to eq(cost + (stand_up.user.cost_per_month*8)/168)
      end
    end
end