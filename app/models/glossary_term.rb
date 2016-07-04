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

class GlossaryTerm < ActiveRecord::Base

  attr_accessible :definition, :name, :url

  validates :definition, :name, presence: true

  class << self
    def ordered
      order("glossary_terms.name")
    end
  end
end
