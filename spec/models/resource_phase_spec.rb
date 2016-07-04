# == Schema Information
#
# Table name: resource_phases
#
#  id          :integer         not null, primary key
#  resource_id :integer         not null
#  phase_id    :integer         not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe ResourcePhase do
  pending "add some examples to (or delete) #{__FILE__}"
end
