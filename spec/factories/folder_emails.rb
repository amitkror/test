# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :folder_email do
    folder nil
    user nil
    recipient "MyString"
    subject "MyString"
    message "MyText"
    cc_me false
  end
end
