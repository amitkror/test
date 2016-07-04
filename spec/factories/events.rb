# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:name) { |n| "Event #{n}" }
  sequence(:start_time) { |n| Date.today.beginning_of_month + n.days  }

  factory :event do
    name { generate(:name) }
    start_datetime { generate(:start_time) }
    end_datetime { generate(:start_time) }
    organization "Stanley Sprockets"
    website "www.google.com"
    cost_text "$200"
    contact_name "Joe Schmoe"
    contact_email "joe.biden@us.gov"
    contact_phone_number "203-867-5309"
    location "111 8th Ave"
    street "8th Ave"
    city "New York"
    state "NY"
    postal_code "10001"
    body ""
    logo_uid nil
    logo_name nil
    attachment_uid nil
    attachment_name nil
    attachment_label nil
  end
end
