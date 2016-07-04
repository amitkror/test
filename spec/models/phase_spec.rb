# == Schema Information
#
# Table name: phases
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  order      :integer         default(0)
#  teaser     :text            default("")
#  page_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Phase do
  pending "add some examples to (or delete) #{__FILE__}"
end
