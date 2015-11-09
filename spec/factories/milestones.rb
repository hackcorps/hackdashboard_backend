FactoryGirl.define do
  factory :milestone do
    name Faker::Name
    percent_complete Faker::Number.between(0, 100)
    data_started Faker::Date.between(2.days.ago, Date.today)
    due_date Faker::Number.between(1, 100)
    cost Faker::Number.between(1, 100)
    organization factory: :organization
  end
end
