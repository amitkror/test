# == Schema Information
#
# Table name: pages
#
#  id                 :integer         not null, primary key
#  status_id          :integer         default(1)
#  page_type_id       :integer         default(1)
#  order              :integer         default(0)
#  locked             :boolean         default(FALSE)
#  in_main_nav        :boolean         default(FALSE)
#  in_sub_nav         :boolean         default(FALSE)
#  title              :string(255)     not null
#  short_title        :string(255)     default("")
#  permalink          :string(255)     not null
#  absolute_url       :string(255)     not null
#  redirect           :string(255)     default("")
#  copy               :text            default("")
#  meta_description   :text            default("")
#  teaser             :text            default("")
#  resources_title    :string(255)     default("Recommended Resources")
#  resources_subtitle :string(255)     default("")
#  ancestry_depth     :integer         default(0)
#  ancestry           :string(255)
#  gallery_id         :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

require 'spec_helper'

describe Page do
  pending "add some examples to (or delete) #{__FILE__}"
end
