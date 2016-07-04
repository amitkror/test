# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :system_avatar do
    name "test"
    image_url "http://farm3.staticflickr.com/2645/3678066534_b533a6eaa2.jpg"
    order 1
  end
end
