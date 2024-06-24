FactoryBot.define do
  factory :sheet do
    name        { Faker::Team.name }
    explanation { Faker::Lorem.sentence }

    association :workspace
  end
end
