FactoryBot.define do
  factory :workspace do
    name        { Faker::Team.name }
    explanation { Faker::Lorem.sentence }
  end
end
