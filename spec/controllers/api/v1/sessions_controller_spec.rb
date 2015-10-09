require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :controller do
	context 'SIGN_IN' do
		context 'AS ADMIN' do
			before(:each) do
				@request.env["devise.mapping"] = Devise.mappings[:admin]
			end

			describe 'POST #create' do
				context 'valid attributes'do
					it 'email and password' do
						#admin = FactoryGirl.create(:admin)

						#post :create, { user: { email: admin.email, password: admin.password } }

						#expect(controller.current_user).to eq(admin)
					end
				end

				context 'invalid attributes' do

				end
			end
		end

		context 'AS CUSTOMER' do
			describe 'POST #create' do

			end
		end

		context 'AS TEAM MEMBER' do
			describe 'POST #create' do

			end
		end

		context 'AS PROJECT MANAGER' do
			describe 'POST #create' do

			end
		end
	end

	context 'SIGH_OUT' do

	end
end