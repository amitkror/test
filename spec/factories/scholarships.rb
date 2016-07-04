# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scholarship do
    name "MyString"
    status_id 1
    end_date "2013-01-29 16:58:50"
    copy "MyText"
    meta_description "MyText"
  end
end
