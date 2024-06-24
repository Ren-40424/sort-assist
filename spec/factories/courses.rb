FactoryBot.define do
  factory :course do
    name { Faker::Lorem.word }
    explanation { Faker::Lorem.sentence }

    association :sheet
  end
end
