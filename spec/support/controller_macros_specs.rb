module ControllerMacrosSpecs
	def sign_in
		before(:each) do
			@current_user ||= FactoryGirl.create(:customer, organizations: [FactoryGirl.create(:organization)])
			token = AuthenticationService.new(@current_user).auth_token
			request.headers['Authorization'] = token
		end
	end
  def sign_out
		before(:each) do
			@current_user ||= FactoryGirl.create(:customer, organizations: [FactoryGirl.create(:organization)])
			token = AuthenticationService.expired(@current_user)
			request.headers['Authorization'] = token
		end
	end
end