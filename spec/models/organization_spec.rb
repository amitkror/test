# == Schema Information
#
# Table name: organizations
#
#  id              :integer         not null, primary key
#  name            :string(255)     not null
#  type_id         :integer
#  status_id       :integer         default(1)
#  permalink       :string(255)     not null
#  resources_count :integer         default(0)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'spec_helper'

describe Organization do
  pending "add some examples to (or delete) #{__FILE__}"
end
