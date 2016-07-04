# == Schema Information
#
# Table name: organizations
#
#  id              :integer         not null, primary key
#  name            :string(255)     not null
#  type_id         :integer
#  status_id       :integer         default(1)
#  permalink       :string(255)     not null
#  resources_count :integer         default(0)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class Organization < AbstractPermalink

  TYPES = {
    "College/University" => 1,
    "Not-For-Profit Organization" => 2,
    "For-Profit Educational Organization" => 3,
    "Faith-Based Organization" => 4,
  }

  has_many :resources

  attr_accessible :name, :permalink, :type_id

  validates :name, presence: true
  validates :permalink, uniqueness: true

  def active_resources
    self.resources.skinny.active.ordered
  end

  def rando_resources(resource)
    self.resources.active.where("id NOT IN (?)", [resource.id]).limit(2)
  end

  def type_s
    return "" if type_id.blank?
    TYPES.find{|key, hash| hash == self.type_id }.first
  end

  class << self
    def ordered
      order("organizations.name")
    end

    def super_skinny
      select(["id", "name"]
          .collect {|s| "organizations.#{s}"}.join(","))
    end

  end

end
