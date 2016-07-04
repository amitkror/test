# == Schema Information
#
# Table name: folders
#
#  id              :integer         not null, primary key
#  user_id         :integer         not null
#  name            :string(255)     not null
#  order           :integer         default(0)
#  bookmarks_count :integer         default(0)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  is_featured     :boolean         default(FALSE)
#  description     :text
#  slug            :string(255)
#

require 'spec_helper'

describe Folder do
  pending "add some examples to (or delete) #{__FILE__}"
end
