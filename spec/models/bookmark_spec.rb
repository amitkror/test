# == Schema Information
#
# Table name: bookmarks
#
#  id          :integer         not null, primary key
#  user_id     :integer         not null
#  folder_id   :integer         not null
#  resource_id :integer         not null
#  order       :integer         default(0)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Bookmark do
  pending "add some examples to (or delete) #{__FILE__}"
end
