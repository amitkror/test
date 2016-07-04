# == Schema Information
#
# Table name: forums
#
#  id                  :integer         not null, primary key
#  name                :string(255)     not null
#  permalink           :string(255)     not null
#  status_id           :integer         default(1)
#  forum_threads_count :integer         default(0)
#  order               :integer         default(0)
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

class Forum < AbstractPermalink

  has_many :forum_threads

  has_many :forum_audiences, dependent: :destroy
  has_many :audiences, through: :forum_audiences


  attr_accessible :name, :permalink, :order, :status_id, :audience_ids

  validates :name, presence: true
  validates :permalink, uniqueness: true

  searchable if: :active? do
    text :name
  end

  def has_audience?(audience_id)
    return self.audience_ids.include?(audience_id) if !self.new_record?
    false
  end

  def clear_audiences
    self.audiences.delete_all
  end  

  def recent_forum_threads
    self.forum_threads.order("updated_at DESC")
  end

  def top_threads
    self.forum_threads.order("comments_count DESC").limit(3)
  end

  class << self

    def ordered
      order("forums.order")
    end

  end

end