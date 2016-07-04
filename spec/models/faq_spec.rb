# == Schema Information
#
# Table name: faqs
#
#  id              :integer         not null, primary key
#  question        :text            not null
#  answer          :text            not null
#  status_id       :integer         default(1)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  page_faqs_count :integer         default(0)
#

require 'spec_helper'

describe Faq do
  pending "add some examples to (or delete) #{__FILE__}"
end
