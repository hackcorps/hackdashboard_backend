FactoryGirl.define do
	factory :user, class: User do
		first_name Faker::Name.first_name
		last_name Faker::Name.last_name
		email Faker::Internet.email
		cost_per_month 0
		password Faker::Internet.password

		factory :admin do
			role 'Admin'
		end

		factory :customer do
			role 'Customer'
		end

		factory :team_member do
			role 'TeamMember'
			cost_per_month 1500
		end

		factory :project_manager do
			role 'ProjectManager'
			cost_per_month 2000
		end
	end
end