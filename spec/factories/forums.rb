# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum do
    name "MyString"
    forum_threads_count 1
    order 1
  end
end
