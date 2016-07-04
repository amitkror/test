# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  content          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  guest_user_id    :integer
#

class Comment < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user
  belongs_to :guest_user

  attr_accessible :content, :user, :user_id, :guest_user_id

  delegate :username, :avatar, to: :user, prefix: true

  validates :content, :commentable_id, presence: true
  validate :user_or_guest_user_presence

  def user_or_guest_user_presence
    if user_id.blank? && guest_user_id.blank?
      errors.add(:guest_user_id, 'Must have a user or guest user id')
    end
  end

  class << self
    def ordered
      order("comments.created_at DESC")
    end

    def to_csv
      comments = Comment.ordered

      header = ["id", "username", "comment", "commented on", "date"]

      csv_string = CSV.generate do |csv|
        csv << header
        # data rows
        comments.each do |comment|
          row = [comment.id, comment.user_username, comment.content,
                 "#{comment.commentable_type} #{comment.commentable_id}",
                 comment.created_at]
          csv << row
        end
      end
      return csv_string
    end

  end
end
