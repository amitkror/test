# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phase do
    name "MyString"
    order 1
    teaser "Lectus augue purus ridiculus porttitor, rhoncus, porttitor elit!"
  end
end
