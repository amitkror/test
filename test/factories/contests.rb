# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contest do
    name "MyString"
    start_date "2014-09-12"
    end_date "2014-09-12"
    body "MyText"
  end
end
