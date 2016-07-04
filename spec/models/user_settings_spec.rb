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
#

require 'spec_helper'

describe UserSettings do
  pending "add some examples to (or delete) #{__FILE__}"
end
