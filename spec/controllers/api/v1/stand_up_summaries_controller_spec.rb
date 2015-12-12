require 'rails_helper'

RSpec.describe Api::V1::StandUpSummariesController, type: :controller do

  let(:organization)  { FactoryGirl.create(:organization) }
  let(:valid_attributes) do
    {
        text: Faker::Lorem.sentence(9),
        noted_date: Date.today,
        organization_id: organization.id
    }
    end

  context 'SIGN IN' do

    sign_in :project_manager

    describe 'GET #index' do
      it 'responds with status 200' do
        get :index

        expect(response.status).to eq 200
      end
      it 'respond with stand-ups at stand-up summaries of user\' organization ' do
        milestone = FactoryGirl.create(:milestone,due_date: Date.today, organization_id: @current_user.organizations.first.id)
        stand_up = FactoryGirl.create(:stand_up, milestone: milestone, user: @current_user )
        FactoryGirl.create(:stand_up_summary, organization_id: @current_user.organizations.first.id)

        get :index

        expect(JSON.parse(response.body)['stand_up_summaries'][0]['stand_ups'].count).to eq(1)
      end

      it 'respond with stand-up summaries of user\' organization' do
        FactoryGirl.create(:stand_up_summary, organization_id: @current_user.organizations.first.id)

        get :index

        expect(JSON.parse(response.body)['stand_up_summaries'].count).to eq(1)
      end

      it 'respond with stand-up summaries of user\' organization from a week' do
        FactoryGirl.create(:stand_up_summary, noted_date: Date.today.beginning_of_week+1, organization_id: @current_user.organizations.first.id)
        FactoryGirl.create(:stand_up_summary, noted_date: Date.today.beginning_of_week+8, organization_id: @current_user.organizations.first.id)

        get :index

        expect(JSON.parse(response.body)['stand_up_summaries'].count).to eq(1)
      end
    end

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
        it 'create the stand-up summary' do
          expect { post :create, stand_up_summary: valid_attributes }
              .to change(StandUpSummary, :count).by(1)
        end
      end
    end
  end

  context 'SIGN OUT' do
    sign_out :project_manager

    describe "POST #create" do
      it 'responds with status 401' do
        post :create, stand_up_summary: valid_attributes

        expect(response.status).to eq 401
      end
    end
    describe 'GET #index' do
      it 'responds with status 401' do
        get :index

        expect(response.status).to eq 401
      end
    end
  end

end
