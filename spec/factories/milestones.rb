FactoryGirl.define do
  factory :milestone do
    sequence(:name){ |id| "Name #{id}" }
    due_date Faker::Number.between(1, 100)
    organization factory: :organization
  end
end
