require 'rails_helper'

RSpec.describe Api::V1::StandUpSummariesController, type: :controller do

  let(:organization)  { FactoryGirl.create(:organization) }
  let(:project_manager) { FactoryGirl.create(:project_manager, organization_ids:  [ organization.id ] ) }
  let(:project_manager_without_organization) { FactoryGirl.create(:project_manager, organization_ids:  [ ] ) }
  let(:valid_attributes) do
    {
        text: Faker::Lorem.sentence(9),
        noted_date: Date.today,
        organization_id: organization.id
    }
    end

  context 'SIGN IN' do

    sign_in :project_manager

    describe "POST #create" do
      context "when stand-up summary params are valid" do
        it 'responds with status 201' do
          post :create, stand_up_summary: valid_attributes

          expect( response.status ).to eq(201)
        end
        it 'responds with stand-up summary' do
          post :create, stand_up_summary: valid_attributes

          expect(JSON.parse(response.body)['stand_up_summary']).not_to be_nil
        end
        it 'create the stand-up' do
          expect { post :create, stand_up_summary: valid_attributes }
              .to change(StandUpSummary, :count).by(1)
        end
      end
    end
  end

  context 'SIGN OUT' do

  end

end
