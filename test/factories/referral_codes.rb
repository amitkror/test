# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :referral_code do
    contest_id 1
    user_id 1
    code "MyString"
  end
end
