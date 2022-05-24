FactoryBot.define do
  factory :address do
    sequence(:street) { |n| "street#{n}" }
    sequence(:postcode) { |n| "postcode#{n}" }
    sequence(:city) { |n| "city#{n}" }
  end
end
