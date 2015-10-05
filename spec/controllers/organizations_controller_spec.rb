require 'rails_helper'

RSpec.describe  OrganizationsController, type: :controller do
  let(:name) {Faker::Company.name }
  let(:organization) { FactoryGirl.create(:organization, name: name) }

  describe 'GET #index' do
   it 'responds with status 200' do
      get :index

      expect(response.status).to eq 200
    end
    it 'responds with organizations' do
      get :index

      expect(JSON.parse(response.body)['organizations']).not_to be_nil
    end
  end

  describe 'POST #create' do
    context 'when created successfully' do
      it 'create organization' do
        expect { post :create, organization: { name: name } }.to change(Organization, :count).by(1)
      end
      it 'expect status 201' do
        post :create, organization: { name: name }
        expect( response.status ).to eq(201)
      end
      it 'expect respond organization' do
        post :create, organization: { name: name }
        last_user = Organization.last

        expect( last_user.name ).to eq(organization.name)
      end
    end
    context 'when create failed' do
      it 'does not create organization' do
        expect { post :create, organization: { name: '' } }.to change(Organization, :count).by(0)
      end
      it 'expect status 422' do
        post :create, organization: { name: '' }
        expect( response.status ).to eq(422)
      end
      it 'responds with errors' do
        post :create, organization: { name: '' }
        expect(JSON.parse(response.body)['errors']).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes own organization' do
      organization_id = FactoryGirl.create(:organization, name: name).id
      delete :destroy, id: organization_id
      expect( Organization.find_by(id: organization_id) ).to be_nil
    end
    it 'expect respond deleted organization' do
      organization = FactoryGirl.create(:organization, name: name)
      delete :destroy, id: organization.id
      expect(JSON.parse(response.body)['organization']['id']).to eq(organization.id)
    end
    it 'expect status 204' do
      organization_id = FactoryGirl.create(:organization, name: name).id
      delete :destroy, id: organization_id
      expect( response.status ).to eq(204)
    end
  end
end
