# == Schema Information
#
# Table name: resources
#
#  id                   :integer         not null, primary key
#  name                 :string(255)     not null
#  type_id              :integer         not null
#  bookmarks_count      :integer         default(0)
#  helpful_count        :integer         default(1)
#  organization_id      :integer
#  website              :string(255)
#  contact_name         :string(255)
#  contact_email        :string(255)
#  contact_phone_number :string(255)
#  street               :string(255)
#  city                 :string(255)
#  state                :string(255)     default("NY")
#  postal_code          :string(255)
#  when_text            :text
#  cost_text            :string(255)
#  size_text            :string(255)
#  is_experts_pick      :boolean
#  conditions_of_use_id :integer
#  body                 :text
#  teaser               :text            default("")
#  logo_uid             :string(255)
#  logo_name            :string(255)
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
#  last_editor_id       :integer
#  keywords             :text            default("")
#

require 'spec_helper'

describe Resource do
  pending "add some examples to (or delete) #{__FILE__}"
end
