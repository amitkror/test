# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :audience do
    name "MyString"
    name_plural "MyStrings"
    show_in_filters true
    show_in_settings true
    order 0
  end
end
