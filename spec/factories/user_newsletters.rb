# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_newsletter do
    user nil
    newsletter nil
  end
end
