# == Schema Information
#
# Table name: user_audiences
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  audience_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  user_text   :text
#

require 'spec_helper'

describe UserAudience do
  pending "add some examples to (or delete) #{__FILE__}"
end
