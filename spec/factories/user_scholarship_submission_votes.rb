# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_scholarship_submission_vote do
    user nil
    scholarship_submission "MyString"
  end
end
