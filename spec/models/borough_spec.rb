# == Schema Information
#
# Table name: boroughs
#
#  id               :integer         not null, primary key
#  name             :string(255)     not null
#  order            :integer         default(0)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  show_in_filters  :boolean         default(TRUE)
#  show_in_settings :boolean         default(TRUE)
#

require 'spec_helper'

describe Borough do
  pending "add some examples to (or delete) #{__FILE__}"
end
