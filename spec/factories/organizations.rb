FactoryGirl.define do
  factory :organization do
    sequence(:name){ |id| "Company name #{id}" }
  end
  factory :invalid_organization, parent: :organization do
    name nil
  end
end