class BlogPost < AbstractPermalink
  
  belongs_to :user
  belongs_to :last_commenter, class_name: "User"
  
  image_accessor :image

  attr_accessible :body, :permalink, :status_id, :title, :image_attributes,
    :last_commenter_id, :last_commented_at, :comments_count, :user_id,
    :image, :tagline, :tags, :tag_ids, :image_url, :meta_title, :meta_keywords,
    :meta_description, :audience_ids

  has_many :comments, { as: :commentable, dependent: :destroy }

  has_and_belongs_to_many :tags

  has_many :blog_post_audiences, dependent: :destroy
  has_many :audiences, through: :blog_post_audiences

  validates :permalink, uniqueness: true
  
  scope :none, limit(0)

  def has_audience?(audience_id)
    return self.audience_ids.include?(audience_id) if !self.new_record?
    false
  end

  def clear_audiences
    self.audiences.delete_all
  end  

  class << self

    def dates
      select('created_at, id')
    end

  	def ordered
      order("created_at DESC")
    end

    def skinny
      select(["id", "title", "permalink", "user_id", "created_at", "status"])
    end

    def published
      where(:status_id => 1)
    end

    def by_month(month)
      month = DateTime.strptime(month, '%Y-%m')
      where(:created_at => month.beginning_of_month..month.end_of_month)
    end

    def by_category(category)
      # where()
      joins(:tags).where('tags.permalink = ?', category)
    end

  end

end

# == Schema Information
#
# Table name: blog_posts
#
#  id                :integer         not null, primary key
#  title             :string(255)
#  permalink         :string(255)
#  body              :text
#  user_id           :integer
#  status_id         :integer
#  image_uid         :string(255)
#  image_name        :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  comments_count    :integer
#  last_commented_at :datetime
#  last_commenter_id :integer
#  tagline           :text
#  meta_title        :string(255)
#  meta_keywords     :string(255)
#  meta_description  :string(255)
#

