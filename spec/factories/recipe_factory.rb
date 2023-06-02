FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    description { Faker::Lorem.paragraph }
    public { Faker::Boolean.boolean }
    preparation_time { Faker::Number.between(from: 10, to: 60) }
    cooking_time { Faker::Number.between(from: 10, to: 120) }
    association :user
  end
end
