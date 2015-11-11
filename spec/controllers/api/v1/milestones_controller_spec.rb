require 'rails_helper'

RSpec.describe Api::V1::MilestonesController, type: :controller do
  let(:organization)  { FactoryGirl.create(:organization) }
  let(:valid_attributes) do
    {
    name: 'Task 1',
    percent_complete: 0,
    data_started: Faker::Date.between(2.days.ago, Date.today),
    due_date: Faker::Number.between(1, 100),
    cost: 1,
    organization_id: organization.id
    }
  end

  let(:invalid_attributes){ {invalid: 'invalid'} }

  describe 'POST #create' do

    context 'with valid params' do
      it 'creates milestone' do
        expect { post :create, milestone: valid_attributes }.to change(Milestone, :count).by(1)
      end
      it 'responds with milestone' do
        post :create, milestone: valid_attributes
        expect(JSON.parse(response.body)['milestone']).not_to be_nil
      end
      it 'responds with status 201' do
        post :create, milestone: valid_attributes
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      it 'does not create event' do
        post :create, milestone: invalid_attributes
        expect( response.status ). to eq(422)
      end
    end
  end

end