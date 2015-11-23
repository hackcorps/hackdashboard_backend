FactoryGirl.define do
	factory :user, class: User do
		full_name Faker::Name.first_name
		email Faker::Internet.email
		password Faker::Internet.password

		factory :admin, parent: :user do
			role 'Admin'
		end

		factory :customer, parent: :user do
			role 'Customer'
		end

		factory :team_member, parent: :user do
			role 'TeamMember'
			cost_per_month 1500

		end

		factory :project_manager, parent: :user do
			role 'ProjectManager'
			cost_per_month 2000
		end
	end
end