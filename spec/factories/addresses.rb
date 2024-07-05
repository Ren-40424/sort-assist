FactoryBot.define do
  factory :address do
    district     { Faker::Address.city }
    address_from { Faker::Number.number }
    address_to   { Faker::Number.number }
    name         { Faker::Name.name }
    explanation  { Faker::Lorem.sentence }
    load_place   { Faker::Number.number }

    association :sheet
    association :course
  end
end
