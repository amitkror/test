# == Schema Information
#
# Table name: events
#
#  id                   :integer         not null, primary key
#  name                 :string(255)     not null
#  start_datetime       :datetime        not null
#  end_datetime         :datetime
#  organization         :string(255)
#  website              :string(255)
#  cost_text            :string(255)
#  contact_name         :string(255)
#  contact_email        :string(255)
#  contact_phone_number :string(255)
#  location             :string(255)
#  street               :string(255)
#  city                 :string(255)
#  state                :string(255)     default("NY")
#  postal_code          :string(255)
#  body                 :text            not null
#  logo_uid             :string(255)
#  logo_name            :string(255)
#  attachment_uid       :string(255)
#  attachment_name      :string(255)
#  attachment_label     :string(255)
#  status_id            :integer         default(1)
#  permalink            :string(255)     not null
#  latitude             :float
#  longitude            :float
#  last_commented_at    :datetime
#  last_commenter_id    :integer
#  comments_count       :integer         default(0)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
