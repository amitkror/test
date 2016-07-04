# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "grad-nyc.team@blenderbox.com"
    password "GSubway123!"
    username "admin"
    role_id 3
  end
end
