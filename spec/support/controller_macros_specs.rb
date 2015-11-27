module ControllerMacrosSpecs
	def sign_in (role = :customer)
		before(:each) do
			@current_user ||= FactoryGirl.create(role, organizations: [FactoryGirl.create(:organization)])
			token = AuthenticationService.new(@current_user).auth_token
			request.headers['Authorization'] = token
		end
	end
  def sign_out (role = :customer)
		before(:each) do
			@current_user ||= FactoryGirl.create(role, organizations: [FactoryGirl.create(:organization)])
			token = AuthenticationService.expired(@current_user)
			request.headers['Authorization'] = token
		end
	end
end