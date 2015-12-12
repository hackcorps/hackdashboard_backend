require 'rails_helper'

RSpec.describe Api::V1::StandUpSummariesController, type: :controller do

  let(:organization)  { FactoryGirl.create(:organization) }
  let(:milestone)  { FactoryGirl.create(:milestone,due_date: Date.today, organization_id: @current_user.organizations.first.id) }
  let(:stand_up_summary) { FactoryGirl.create(:stand_up_summary, organization_id: @current_user.organizations.first.id) }

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

    describe 'DELETE #destroy' do
      before :each do
        @stand_up = FactoryGirl.create(:stand_up, milestone: milestone, user: @current_user )
        @stand_up_summary = FactoryGirl.create(:stand_up_summary, organization_id: @current_user.organizations.first.id)
      end

      it 'responds with status 200' do
        delete :destroy, id: @stand_up_summary.id

        expect(response.status).to eq(200)
      end
      it 'respond with status 404 if stand-up summary id is not valid' do
        delete :destroy, id: 0

        expect(response.status).to eq(404)
      end
      it 'deletes associated stand-ups' do
        delete :destroy, id: @stand_up_summary.id

        expect (StandUp.all.where(stand_up_summary_id:  @stand_up_summary.id).count).eql?(0)
      end
      it 'deletes stand-up summary of user' do
        expect { delete :destroy, id: @stand_up_summary.id }.to change(StandUpSummary, :count).by(-1)
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

    describe 'DELETE #destroy' do
      it 'responds with status 401' do
        delete :destroy, id: stand_up_summary.id

        expect(response.status).to eq 401
      end
    end
  end

end
