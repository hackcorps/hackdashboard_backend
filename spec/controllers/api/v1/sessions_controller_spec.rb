require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :controller do
	context 'SIGN_IN' do
		context 'AS ADMIN' do
			before(:each) do
				@request.env["devise.mapping"] = Devise.mappings[:admin]
			end

			describe 'POST #create' do
				let(:admin){ FactoryGirl.create(:admin) }

				context 'valid attributes'do
					it 'email and password' do
						post :create, { user: { email: admin.email, password: admin.password } }

						expect(response_as_json[:user][:email]).to eq(admin.email)
						expect(response_as_json[:user][:role]).to eq(admin.role)
						expect(response_as_json[:user][:auth_token]).not_to be_empty
					end
				end

				context 'invalid attributes' do
					it 'email and password' do
						post :create, { user: { email: '', password: '' } }

						expect(response_as_json).to eq({ 'errors' => ["Email can't be blank", "Password can't be blank"] })
					end
				end
			end
		end

		context 'AS CUSTOMER' do
			before(:each) do
				@request.env["devise.mapping"] = Devise.mappings[:user]
			end

			describe 'POST #create' do
				context 'valid attributes' do
					it 'email and password' do
						customer = FactoryGirl.create(:customer)

						post :create, { user: { email: customer.email, password: customer.password } }

						expect(response_as_json[:user][:email]).to eq(customer.email)
						expect(response_as_json[:user][:role]).to eq(customer.role)
						expect(response_as_json[:user][:auth_token]).not_to be_empty
					end
				end

				context 'invalid attributes' do
					it 'email and password' do
						post :create, { user: { email: '', password: '' } }

						expect(response_as_json).to eq({ 'errors' => ["Email can't be blank", "Password can't be blank"] })
					end
				end
			end
		end

		context 'AS TEAM MEMBER' do
			before(:each) do
				@request.env["devise.mapping"] = Devise.mappings[:user]
			end

			describe 'POST #create' do
				context 'valid attributes' do
					it 'email and password' do
						team_member = FactoryGirl.create(:team_member)

						post :create, { user: { email: team_member.email, password: team_member.password } }

						expect(response_as_json[:user][:email]).to eq(team_member.email)
						expect(response_as_json[:user][:role]).to eq(team_member.role)
						expect(response_as_json[:user][:auth_token]).not_to be_empty
					end
				end

				context 'invalid attributes' do
					it 'email and password' do
						post :create, { user: { email: '', password: '' } }

						expect(response_as_json).to eq({ 'errors' => ["Email can't be blank", "Password can't be blank"] })
					end
				end
			end
		end

		context 'AS PROJECT MANAGER' do
			before(:each) do
				@request.env["devise.mapping"] = Devise.mappings[:user]
			end

			describe 'POST #create' do
				context 'valid attributes' do
					it 'email and password' do
						project_manager = FactoryGirl.create(:project_manager)

						post :create, { user: { email: project_manager.email, password: project_manager.password } }

						expect(response_as_json[:user][:email]).to eq(project_manager.email)
						expect(response_as_json[:user][:role]).to eq(project_manager.role)
						expect(response_as_json[:user][:auth_token]).not_to be_empty
					end
				end

				context 'invalid attributes' do
					it 'email and password' do
						post :create, { user: { email: '', password: '' } }

						expect(response_as_json).to eq({ 'errors' => ["Email can't be blank", "Password can't be blank"] })
					end
				end
			end
		end
	end


	shared_examples_for 'sign_out' do
		it 'from service' do
			expect(controller.current_user).to be_present

			delete :destroy
			expect(controller.current_user).to be_nil
			expect(response_as_json).to eq({})
		end
	end

	context 'SIGH_OUT' do
		context 'AS ADMIN' do
			sign_in_as_admin

			it_behaves_like('sign_out')
		end

		context 'AS CUSTOMER' do
			sign_in_as_customer

			it_behaves_like('sign_out')
		end
		context 'AS TEAM MEMBER' do
			sign_in_as_team_member

			it_behaves_like('sign_out')
		end
		context 'AS PROJECT MANAGER' do
			sign_in_as_project_manager

			it_behaves_like('sign_out')
		end
	end
end