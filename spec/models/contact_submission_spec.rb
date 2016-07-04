# == Schema Information
#
# Table name: contact_submissions
#
#  id         :integer         not null, primary key
#  title      :string(255)     not null
#  name       :string(255)     not null
#  email      :string(255)     not null
#  message    :text            not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe ContactSubmission do
  pending "add some examples to (or delete) #{__FILE__}"
end
