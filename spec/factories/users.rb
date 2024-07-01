FactoryBot.define do
  factory :user do
    name { 'user' }
    email { 'example.example.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
