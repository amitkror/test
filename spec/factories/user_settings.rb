# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_setting, :class => 'UserSettings' do
    user nil
    notify_folder_update false
    notify_thread_comments false
    notify_resource_comments false
  end
end
