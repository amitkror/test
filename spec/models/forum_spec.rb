# == Schema Information
#
# Table name: forums
#
#  id                  :integer         not null, primary key
#  name                :string(255)     not null
#  permalink           :string(255)     not null
#  status_id           :integer         default(1)
#  forum_threads_count :integer         default(0)
#  order               :integer         default(0)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

require 'spec_helper'

describe Forum do
  pending "add some examples to (or delete) #{__FILE__}"
end
