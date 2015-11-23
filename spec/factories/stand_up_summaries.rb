FactoryGirl.define do
  factory :stand_up_summary do
    noted_date Date.today
    text Faker::Lorem.sentences(2)
    organization :nil
  end

end
