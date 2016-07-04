# == Schema Information
#
# Table name: folders
#
#  id              :integer         not null, primary key
#  user_id         :integer         not null
#  name            :string(255)     not null
#  order           :integer         default(0)
#  bookmarks_count :integer         default(0)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  is_featured     :boolean         default(FALSE)
#  description     :text
#  slug            :string(255)
#

class Folder < ActiveRecord::Base

  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  has_many :resources, through: :bookmarks

  has_many :folder_recommendations, dependent: :destroy
  attr_accessible :name, :order, :user, :description, :is_featured, :slug

  validates :user, :name, presence: true
  validates :name, length: { maximum: 100 }

  # validates :slug, uniqueness: true

  before_create :set_order

  belongs_to :public_folder_connections, dependent: :destroy

  def update_bookmarks_count
    self.bookmarks_count = self.bookmarks.count
    self.save if self.bookmarks_count_changed?
  end

  private
    def set_order
      self.order = self.user.folders.count unless self.user.blank?
    end

  class << self
    def ordered
      order("folders.order, folders.name")
    end

    def belongs_to_user(uid)
      where(user_id: uid).select('id, name').map { |x| [x.name, x.id] }
    end

    def featured
      where(is_featured: true)
    end

    def to_csv
      folders = Folder.ordered

      header = ["user", "folder name", "number of resources", "date"]

      csv_string = CSV.generate do |csv|
        csv << header
        # data rows
        folders.each do |folder|
          row = [folder.user.username, folder.name, folder.bookmarks.count,
                 folder.created_at]
          csv << row
        end
      end
      return csv_string
    end

  end
end
