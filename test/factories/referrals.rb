# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :referral do
    referrer_id 1
    referred_id 1
    referral_code_id 1
  end
end
