# == Schema Information
#
# Table name: subway_lines
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  order      :integer         default(0)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe SubwayLine do
  pending "add some examples to (or delete) #{__FILE__}"
end
