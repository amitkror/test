# == Schema Information
#
# Table name: glossary_terms
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  url        :string(255)
#  definition :text            not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe GlossaryTerm do
  pending "add some examples to (or delete) #{__FILE__}"
end
