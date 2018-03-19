FactoryBot.define do
  factory :user do
    name { Faker::StarWars.character[1..50] }
    email { Faker::Internet.email }
  end
end
