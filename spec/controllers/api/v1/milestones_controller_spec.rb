require 'rails_helper'

RSpec.describe Api::V1::MilestonesController, type: :controller do
  let(:organization_first)  { FactoryGirl.create(:organization) }
  let(:organization_second)  { FactoryGirl.create(:organization) }
  let(:milestone) { FactoryGirl.create :milestone }

  let(:valid_attributes) do
    {
      name: 'Task 1',
      percent_complete: 45,
      data_started: Faker::Date.between(2.days.ago, Date.today),
      due_date: Faker::Date.between(Date.today, 2.days.from_now),
      cost: 120,
      organization_id: organization_first.id
    }
  end
  let(:valid_attributes_without_organization) do
    {
        name: 'Task 1',
        percent_complete: 45,
        data_started: Faker::Date.between(2.days.ago, Date.today),
        due_date: Faker::Date.between(Date.today, 2.days.from_now),
        cost: 120
    }
  end
  let(:invalid_attributes){ {invalid: 'invalid'} }

  context 'SIGN IN' do

    sign_in

    describe 'GET #index' do
    it 'responds with status 200' do
      get :index
      expect(response.status).to eq 200
    end

    it 'respond with milestones' do
     FactoryGirl.create_list(:milestone, 2, organization_id: @current_user.organizations.first.id)

     get :index

     expect(JSON.parse(response.body)['milestones'].count).to eq 2
    end

    it 'returns existing milestones of organization' do
      FactoryGirl.create_list(:milestone, 2, organization_id: @current_user.organizations.first.id)
      FactoryGirl.create(:milestone, organization_id: organization_second.id)

      get :index

      expect(controller.current_user.organizations.first.milestones.count).to eq(2)
    end

  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'creates milestone' do
        expect { post :create, milestone: valid_attributes }.to change(Milestone, :count).by(1)
      end
      it 'creates milestone for a current user' do
        post :create, milestone: valid_attributes_without_organization
        milestone = Milestone.last
        expect( milestone.organization).to eq(@current_user.organizations.first)
      end
      it 'creates milestone for a current user without organization' do
        @current_user.organizations.delete_all

        post :create, milestone: valid_attributes_without_organization

        milestone = Milestone.last

        expect( response.status ). to eq(422)
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
      it 'does not create milestone' do
        post :create, milestone: invalid_attributes
        expect( response.status ). to eq(422)
      end
      it 'responds with errors' do
        post :create, milestone: {name: 'Task'}
        expect(JSON.parse(response.body)['errors']).not_to be_nil
      end
    end

  end

  describe 'PUT #update' do

    context 'with valid params' do
      before :each do
       put :update, id: milestone.id, milestone: valid_attributes
       milestone.reload
      end

      it "changes @milestone\'s attributes" do
        expect(milestone.percent_complete).to eq(valid_attributes[:percent_complete])
        expect(milestone.cost).to eq(valid_attributes[:cost])
      end
      it 'responds with status 200' do
        expect( response.status ). to eq(200)
      end
      it 'responds with milestone' do
        expect(JSON.parse(response.body)['milestone']).not_to be_nil
      end
    end

    context 'with invalid params' do
      it 'responds with errors' do
        put :update, id: milestone.id, milestone: {name: ''}

        expect(JSON.parse(response.body)['errors']).not_to be_nil
      end
      it 'respond with status 404' do
        put :update, id: 0, milestone: valid_attributes

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
     @milestone = FactoryGirl.create :milestone
    end

    it 'deletes milestone' do
      expect { delete :destroy, id: @milestone.id }.to change(Milestone, :count).by(-1)
    end
    it 'responds with status 200' do
      delete :destroy, id: @milestone.id

      expect(response.status).to eq(200)
    end
    it 'responds with status  404' do
      delete :destroy, id: 0

      expect(response.status).to eq(404)
    end
  end

  end

  context 'SIGN OUT' do

    sign_out

    describe 'GET #index' do
      it 'responds with status 401' do
        get :index

        expect(response.status).to eq 401
      end
    end

    describe 'POST #create' do
      it 'responds with status 401' do
        post :create, milestone: valid_attributes

        expect(response.status).to eq 401
      end
    end

    describe 'PUT #update' do
      it 'responds with status 401' do
        put :update, id: milestone.id, milestone: valid_attributes

        expect(response.status).to eq 401
      end
    end
    describe 'DELETE #destroy' do
      it 'responds with status 401' do
        delete :destroy, id: milestone.id

        expect(response.status).to eq 401
      end
    end
  end

  end