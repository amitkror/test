# == Schema Information
#
# Table name: user_newsletters
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  newsletter_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe UserNewsletter do
  pending "add some examples to (or delete) #{__FILE__}"
end
