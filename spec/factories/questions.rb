# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    user nil
    adviser nil
    topic nil
    subject "MyString"
    question "MyText"
    accepts_tos false
  end
end
