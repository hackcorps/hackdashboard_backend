#FactoryGirl.define do
#	factory :user, class: User do
#		first_name: Faker::Name.first_name
#		last_name: Faker::Name.last_name
#		email: Faker::Internet.email
#		role: 'User'
#	end
#
#	factory :admin do
#		role: 'Admin'
#	end
#
#	factory :customer do
#		role: 'Customer'
#	end
#
#	factory :team_member do
#		role: 'Team member'
#		cost_per_month: 1500
#	end
#
#	factory :project_manager do
#		role: 'Project manager'
#		cost_per_month: 2000
#	end
#end