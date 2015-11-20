FactoryGirl.define do
  factory :milestone do
    sequence(:name){ |id| "Name #{id}" }
    due_date Faker::Date.between(Date.today, 2.days.from_now)
    organization factory: :organization
  end
end
