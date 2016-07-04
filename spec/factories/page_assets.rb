# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page_asset do
    page nil
    asset nil
    order 1
  end
end
