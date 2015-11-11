FactoryGirl.define do
  factory :milestone do
    name Faker::Name
    due_date Faker::Number.between(1, 100)
    organization factory: :organization
  end
end
