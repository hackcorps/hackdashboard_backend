require 'rails_helper'

RSpec.describe Api::V1::StandUpsController, type: :controller do
  let(:organization)  { FactoryGirl.create(:organization) }
  let(:milestone) { FactoryGirl.create(:milestone, organization_id: organization.id) }
  let(:team_member) { FactoryGirl.create(:team_member, email: 'teammember@gmail.com', organization_ids:  [ organization.id ]) }
  let(:stand_up) { FactoryGirl.create(:stand_up, user_id: team_member.id, milestone_id: milestone.id) }
  let(:params) { Hash[ update_text: Faker::Lorem.sentence(9), noted_at: Date.today ] }

  context 'SIGN IN' do

    sign_in :team_member

    let(:milestone) { FactoryGirl.create(:milestone, organization:  @current_user.organizations.first) }
    let(:valid_attributes) do
      {
          update_text: Faker::Lorem.sentence(9),
          noted_at: Date.today,
          milestone_id: milestone.id,
          stand_up_summary_id: nil
      }
    end
    describe "GET #index" do
      it 'responds with status 200' do
        get :index

        expect(response.status).to eq 200
      end

      it 'responds with user\'s stand-up' do
        FactoryGirl.create(:stand_up, user_id: @current_user.id, milestone_id: milestone.id)
        FactoryGirl.create(:stand_up, user_id: team_member.id, milestone_id: milestone.id)

        get :index

        expect(JSON.parse(response.body)['stand_ups'].count).to eq(2)
      end
    end

    describe "POST #create" do
      context "when stand-up params are valid" do
        it 'responds with status 201' do
          post :create, stand_up: valid_attributes

          expect(response.status).to eq(201)
        end
        it 'responds with stand-up' do
          post :create, stand_up: valid_attributes

          expect(JSON.parse(response.body)['stand_up']).not_to be_nil
        end
        it 'create the stand-up' do
          expect { post :create, stand_up: valid_attributes }
              .to change(StandUp, :count).by(1)
        end
      end
      context "when stand-up params are invalid" do
        it 'responds with status 422' do
          post :create, stand_up: { update_text: '' }

          expect(response.status).to eq 422
        end
        it 'responds with errors' do
          post :create, stand_up: { updated_text: ''}

          expect(JSON.parse(response.body)['errors']).not_to be_nil
        end
        it 'does not create the stand-up' do
          expect { post :create,stand_up: { update_text: ''} }
              .to change(StandUp, :count).by(0)
        end
      end
    end

      describe 'PUT #update' do

      before :each do
        @stand_up = FactoryGirl.create(:stand_up, user_id: @current_user.id, milestone_id: milestone.id)
      end

      context 'with valid params' do
        it 'responds with status 200' do
          put :update, id: @stand_up.id, stand_up: params

          expect(response.status).to eq 200
        end
        it 'updates stand-up' do
          put :update, id: @stand_up.id, stand_up: params

          expect(@stand_up.reload.update_text).to eq params[:update_text]
        end
        it 'responds with stand-up' do
          put :update, id: @stand_up.id, stand_up: params

          expect(JSON.parse(response.body)['stand_up']).not_to be_nil
        end

      end

      context 'with invalid params' do
        it 'responds with errors' do
          put :update, id: @stand_up.id, stand_up: {update_text: ''}

          expect(JSON.parse(response.body)['errors']).not_to be_nil
        end
        it 'respond with status 404' do
          put :update, id: 0, stand_up: valid_attributes

          expect(response.status).to eq(404)
        end
      end
    end

    describe 'DELETE #destroy' do
      before :each do
        @stand_up = FactoryGirl.create(:stand_up, user_id: @current_user.id, milestone_id: milestone.id)
      end

      it 'responds with status 200' do
        delete :destroy, id: @stand_up.id

        expect(response.status).to eq(200)
      end
      it 'deletes stand-up' do
        expect { delete :destroy, id: @stand_up.id }.to change(StandUp, :count).by(-1)
      end
      it 'respond with status 404' do
        delete :destroy, id: 0

        expect(response.status).to eq(404)
      end
    end
  end

  context 'SIGN OUT' do

    sign_out :team_member

    describe "POST #create" do
      it 'responds with status 401' do
        post :create, stand_up: FactoryGirl.attributes_for(:stand_up, milestone_id: milestone.id)

        expect(response.status).to eq 401
      end
    end
    describe 'GET #index' do
      it 'responds with status 401' do
        get :index

        expect(response.status).to eq 401
      end
    end

    describe 'PUT #update' do
      it 'responds with status 401' do
        put :update, id: stand_up.id, stand_up: params

        expect(response.status).to eq 401
      end
    end

    describe 'DELETE #destroy' do
      it 'responds with status 401' do
        delete :destroy, id: stand_up.id

        expect(response.status).to eq 401
      end
    end
  end
end
