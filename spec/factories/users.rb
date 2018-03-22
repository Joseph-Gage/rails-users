FactoryBot.define do
  factory :user do
    name { Faker::Internet.user_name(1..50) }
    email { Faker::Internet.email }
    password { Faker::Internet.password(10, 20) }
    password_confirmation { password }
  end
end
