# == Schema Information
#
# Table name: folder_emails
#
#  id         :integer         not null, primary key
#  folder_id  :integer         not null
#  user_id    :integer         not null
#  recipient  :string(255)     not null
#  subject    :string(255)     not null
#  message    :text
#  cc_me      :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe FolderEmail do
  pending "add some examples to (or delete) #{__FILE__}"
end
