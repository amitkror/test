# == Schema Information
#
# Table name: conditions_of_uses
#
#  id         :integer         not null, primary key
#  title      :string(255)     not null
#  copy       :text            not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ConditionsOfUse < ActiveRecord::Base

  attr_accessible :copy, :title

  class << self

    def super_skinny
      select(["id", "title"]
          .collect {|s| "conditions_of_uses.#{s}"}.join(","))
    end

  end
end
