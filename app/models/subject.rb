# == Schema Information
#
# Table name: subjects
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  order      :integer         default(0)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Subject < ActiveRecord::Base

  attr_accessible :name, :order

  validates :name, presence: true

  class << self
    def ordered
      order("subjects.order")
    end
  end
end
