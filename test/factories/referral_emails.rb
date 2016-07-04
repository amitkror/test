# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :referral_email do
    referral_id 1
    user_id 1
    recipient "MyString"
    subject "MyString"
    message "MyText"
    cc_me false
  end
end
