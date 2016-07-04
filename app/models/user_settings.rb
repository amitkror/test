# == Schema Information
#
# Table name: user_settings
#
#  id                          :integer         not null, primary key
#  user_id                     :integer
#  notify_folder_update        :boolean
#  notify_thread_comments      :boolean
#  notify_resource_comments    :boolean
#  created_at                  :datetime        not null
#  updated_at                  :datetime        not null
#  notify_question_assignments :boolean         default(FALSE)
#  notify_blog_comments        :boolean
#

class UserSettings < ActiveRecord::Base

  belongs_to :user

  attr_accessible :notify_folder_update, :notify_question_assignments,
                  :notify_resource_comments, :notify_thread_comments,
                  :notify_blog_comments
end
