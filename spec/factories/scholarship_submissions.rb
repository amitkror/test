# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scholarship_submission do
    first_name "MyString"
    last_name "MyString"
    high_school "MyString"
    year_in_school "MyString"
    email "MyString"
    phone "MyString"
    state "MyString"
    birth_month "MyString"
    birth_year "MyString"
    not_currently_enrolled false
    of_age_or_consent false
    document_uid "MyString"
    document_name "MyString"
    video_url "MyString"
    description "MyText"
    agree_to_terms false
    scholarship nil
  end
end
