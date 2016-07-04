# == Schema Information
#
# Table name: page_faqs
#
#  id         :integer         not null, primary key
#  page_id    :integer
#  faq_id     :integer
#  order      :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe PageFaq do
  pending "add some examples to (or delete) #{__FILE__}"
end
