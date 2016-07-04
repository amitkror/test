# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :folder do
    user nil
    name "MyString"
    order 1
  end
end
