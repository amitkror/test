# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource_suggestion do
    user nil
    type nil
    attachement_uid "MyString"
    attachment_name "MyString"
    link "MyString"
    title "MyString"
    description "MyText"
    accepts_tos false
  end
end
