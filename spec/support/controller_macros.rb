module ControllerMacros
	def sign_in_as_admin
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:admin]
			@current_user = FactoryGirl.create(:admin)
			sign_in @current_user
		end
	end

	def sign_in_as_customer
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:customer]
			@current_user = FactoryGirl.create(:customer)
			sign_in @current_user
		end
	end

	def sign_in_as_team_member
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:team_member]
			@current_user = FactoryGirl.create(:team_member)
			sign_in @current_user
		end
	end

	def sign_in_as_project_manager
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:project_manager]
			@current_user = FactoryGirl.create(:project_manager)
			sign_in @current_user
		end
	end

	def sign_out_user
		before(:each) do
			sign_out(@current_user) rescue nil
		end
	end
end