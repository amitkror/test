# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :newsletter do
    name "MyString"
    mc_template_name "MyString"
    mc_template_id "MyString"
    mc_list_name "MyString"
    mc_list_id "MyString"
    last_sent_at "2012-08-17 12:13:52"
    mc_interest_groups "MyText"
    status_id 2
  end
end
