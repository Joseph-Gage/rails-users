FactoryBot.define do
  factory :user do
    name { Faker::Internet.user_name(1..50) }
    email { Faker::Internet.email }
  end
end
