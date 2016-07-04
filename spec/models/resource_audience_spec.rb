# == Schema Information
#
# Table name: resource_audiences
#
#  id          :integer         not null, primary key
#  resource_id :integer         not null
#  audience_id :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe ResourceAudience do
  pending "add some examples to (or delete) #{__FILE__}"
end
