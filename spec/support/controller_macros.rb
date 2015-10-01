module ControllerMacros
	def sign_in_as_admin
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:admin]
			sign_in FactoryGirl.create(:admin) # Using factory girl as an example
		end
	end

	def sign_in_as_customer
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:customer]
			# user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
			sign_in FactoryGirl.create(:customer)
		end
	end

	def sign_in_as_team_member
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:team_member]
			# user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
			sign_in FactoryGirl.create(:team_member)
		end
	end

	def sign_in_as_project_manager
		before(:each) do
			@request.env["devise.mapping"] = Devise.mappings[:project_manager]
			# user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
			sign_in FactoryGirl.create(:project_manager)
		end
	end
end