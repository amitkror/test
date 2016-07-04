# == Schema Information
#
# Table name: promos
#
#  id         :integer         not null, primary key
#  is_locked  :boolean         default(TRUE)
#  is_image   :boolean         default(FALSE)
#  title      :string(255)     not null
#  control    :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Promo do
  pending "add some examples to (or delete) #{__FILE__}"
end
