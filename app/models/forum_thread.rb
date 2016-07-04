# == Schema Information
#
# Table name: forum_threads
#
#  id                :integer         not null, primary key
#  forum_id          :integer         not null
#  user_id           :integer         not null
#  name              :string(255)     not null
#  permalink         :string(255)     not null
#  status_id         :integer         default(1)
#  message           :text
#  last_commented_at :datetime
#  last_commenter_id :integer
#  comments_count    :integer         default(0)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#

class ForumThread < AbstractPermalink

  belongs_to :forum, counter_cache:true
  belongs_to :last_commenter, class_name: "User"
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  attr_accessible :forum_id, :last_commented_at, :message, :name, :user

  delegate :username, :avatar, to: :user, prefix: true

  validates :forum, :name, presence: true

  searchable if: :active? do

    text :name
    text :message

    text :comments do
      comments.map { |comment| comment.content }
    end

    text :username do
      self.user.username
    end
  end

  def last_comment
    comment = self.comments.last

    return "" if comment.blank?

    comment.content
  end

  private
    def make_permalink

      return true unless permalink.blank?

      o = [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
      self.permalink = (0..18).map{ o[rand(o.length)] }.join
    end

  class << self
    def ordered
      order("forum_threads.created_at DESC, forum_threads.name")
    end

    def recent
      order("created_at DESC").limit(3)
    end
  end
end
