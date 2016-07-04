# == Schema Information
#
# Table name: newsletters
#
#  id                 :integer         not null, primary key
#  name               :string(255)     not null
#  mc_template_name   :string(255)
#  mc_template_id     :string(255)
#  mc_list_name       :string(255)
#  mc_list_id         :string(255)
#  last_sent_at       :datetime
#  mc_interest_groups :text
#  status_id          :integer         default(1), not null
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

class Newsletter < ActiveRecord::Base

  STATUSES = {
    Inactive: 1,
    Active: 2,
  }

  attr_accessible :last_sent_at, :mc_interest_groups, :mc_list_id,
                  :mc_list_name, :mc_template_id, :mc_template_name,
                  :name, :status_id

  validates :name, presence: true

  def active?
    return self.status_id == STATUSES[:Inactive]
  end

  def inactive?
    return self.status_id == STATUSES[:Active]
  end

  class << self

    def active
      where(status_id: STATUSES[:Active])
    end
  end
end
