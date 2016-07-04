# == Schema Information
#
# Table name: conditions_of_uses
#
#  id         :integer         not null, primary key
#  title      :string(255)     not null
#  copy       :text            not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe ConditionsOfUse do
  pending "add some examples to (or delete) #{__FILE__}"
end
