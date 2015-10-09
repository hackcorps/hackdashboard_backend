FactoryGirl.define do
	factory :user, class: User do
		first_name Faker::Name.first_name
		last_name Faker::Name.last_name
		email Faker::Internet.email
		cost_per_month 0
		password Faker::Internet.password

		factory :admin do
			role_id FactoryGirl.create(:role_admin).id
		end

		factory :customer do
			role_id FactoryGirl.create(:role_customer).id
		end

		factory :team_member do
			role_id FactoryGirl.create(:role_team_member).id
			cost_per_month 1500
		end

		factory :project_manager do
			role_id FactoryGirl.create(:role_project_manager).id
			cost_per_month 2000
		end
	end
end