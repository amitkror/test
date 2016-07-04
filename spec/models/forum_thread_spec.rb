# == Schema Information
#
# Table name: forum_threads
#
#  id                :integer         not null, primary key
#  forum_id          :integer         not null
#  user_id           :integer         not null
#  name              :string(255)     not null
#  permalink         :string(255)     not null
#  status_id         :integer         default(1)
#  message           :text
#  last_commented_at :datetime
#  last_commenter_id :integer
#  comments_count    :integer         default(0)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

require 'spec_helper'

describe ForumThread do
  pending "add some examples to (or delete) #{__FILE__}"
end
