# == Schema Information
#
# Table name: newsletters
#
#  id                 :integer         not null, primary key
#  name               :string(255)     not null
#  mc_template_name   :string(255)
#  mc_template_id     :string(255)
#  mc_list_name       :string(255)
#  mc_list_id         :string(255)
#  last_sent_at       :datetime
#  mc_interest_groups :text
#  status_id          :integer         default(1), not null
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

require 'spec_helper'

describe Newsletter do
  pending "add some examples to (or delete) #{__FILE__}"
end
