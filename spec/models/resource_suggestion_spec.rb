# == Schema Information
#
# Table name: resource_suggestions
#
#  id              :integer         not null, primary key
#  user_id         :integer         not null
#  type_id         :integer
#  attachment_uid  :string(255)
#  attachment_name :string(255)
#  link            :string(255)
#  title           :string(255)
#  description     :text
#  accepts_tos     :boolean
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  was_used        :boolean         default(FALSE)
#

require 'spec_helper'

describe ResourceSuggestion do
  pending "add some examples to (or delete) #{__FILE__}"
end
