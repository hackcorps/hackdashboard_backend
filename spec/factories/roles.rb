FactoryGirl.define do
  factory :role, class: Role do
    factory :role_admin do
	    name :admin
    end

	  factory :role_customer do
		  name :customer
	  end

	  factory :role_project_manager do
		  name :project_manager
	  end

	  factory :role_team_member do
		  name :team_member
	  end
  end
end
