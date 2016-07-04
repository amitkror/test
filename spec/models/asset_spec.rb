# == Schema Information
#
# Table name: assets
#
#  id              :integer         not null, primary key
#  title           :string(255)     default("")
#  alt             :string(255)     default("")
#  page_id         :integer
#  link            :string(255)
#  attachment_uid  :string(255)     not null
#  attachment_name :string(255)     not null
#  is_image        :boolean         default(FALSE)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'spec_helper'

describe Asset do
  pending "add some examples to (or delete) #{__FILE__}"
end
