require 'rails_helper'

RSpec.describe Api::V1::Users::PasswordsController, type: :controller do
	describe 'POST #create' do
		context 'valid params' do
			it 'when user exists' do
				@request.env["devise.mapping"] = Devise.mappings[:user]
				user = FactoryGirl.create(:user)
				organization = FactoryGirl.create(:organization)
				FactoryGirl.create(:user_organization, organization: organization, user: user)

				post :create
			end
		end

		context 'invalid params' do
			it 'when user is missing' do

			end
		end
	end

	describe 'PUT #update' do
		context 'valid params' do

		end

		context 'invalid params' do

		end
	end
end
