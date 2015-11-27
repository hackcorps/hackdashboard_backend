FactoryGirl.define do
  factory :stand_up do
    update_text Faker::Lorem.sentence(8)
    noted_at Date.today
    user nil
    milestone nil
    stand_up_summary nil
  end

end
