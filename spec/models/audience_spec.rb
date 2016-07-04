# == Schema Information
#
# Table name: audiences
#
#  id                :integer         not null, primary key
#  name              :string(255)     not null
#  name_plural       :string(255)
#  order             :integer         default(0)
#  show_in_filters   :boolean         default(TRUE)
#  show_in_settings  :boolean         default(TRUE)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  display_user_text :boolean         default(FALSE)
#  placeholder_text  :string(255)
#  newsletter_id     :integer
#

require 'spec_helper'

describe Audience do
  pending "add some examples to (or delete) #{__FILE__}"
end
