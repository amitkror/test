# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page_resource do
    page nil
    resource nil
    order 1
  end
end
