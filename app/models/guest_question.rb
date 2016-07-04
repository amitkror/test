# == Schema Information
#
# Table name: guest_questions
#
#  id                      :integer         not null, primary key
#  guest_user_id           :integer         not null
#  adviser_id              :integer
#  question                :text
#  answered                :boolean         default(FALSE)
#  accepts_tos             :boolean         default(TRUE)
#  new_comment_for_user    :boolean         default(FALSE)
#  new_for_adviser         :boolean         default(FALSE)
#  new_comment_for_adviser :boolean         default(FALSE)
#  last_commented_at       :datetime
#  last_commenter_id       :integer
#  comments_count          :integer         default(0)
#  created_at              :datetime        not null
#  updated_at              :datetime        not null
#

class GuestQuestion < ActiveRecord::Base
  attr_accessible :accepts_tos, :adviser_id, :last_commented_at, :question,
                  :subject, :topic_id

  belongs_to :guest_user
  belongs_to :adviser, class_name: "User"
  belongs_to :topic, class_name: "Subject"
  belongs_to :last_commenter, class_name: "User"
  has_many :comments, { as: :commentable, dependent: :destroy }

  delegate :email, :username, to: :adviser, prefix: true, allow_nil: true
  delegate :name, to: :topic, prefix: true, allow_nil: true

  validates :question, :accepts_tos, presence: true
  before_validation :check_assignee

  def assigned?
    !adviser.blank?
  end

  def user_email
    guest_user.email
  end

  def user_username
    user_email
  end

  def last_commenter_username
    if last_commenter == guest_user
      guest_user.email
    else
      last_commenter.username
    end
  end

  def user
    guest_user
  end

  def check_assignee
    if self.adviser_id_changed?
      self.new_for_adviser = true
      unless self.adviser.blank?
        QuestionMailer.delay(queue: 'questions').send_assigned(self)
      end
    end
  end

  def on_commented
    QuestionMailer.delay(queue: 'questions').send_commented(self) unless !self.answered?
    mark_unread(self.last_commenter)
    mark_answered(self.last_commenter)
    # QuestionMailer.delay(queue: 'questions').send_commented(self)
  end

  def mark_answered(u)
    return self.answered if self.answered
    if assigned? && u.id == self.adviser.id
      QuestionMailer.delay(queue: 'questions').send_answered(self)
      self.answered = true
      self.save
    end
  end

  def mark_read(u)
    if !self.adviser.blank? && u.id == self.adviser.id
      self.new_comment_for_adviser = false
      self.new_for_adviser = false
    else
      self.new_comment_for_user = false
    end
    self.save
  end

  def mark_unread(last_commenter)
    commenter = last_commenter.blank? ? self.guest_user : last_commenter
    if commenter.is_a?(User)
      self.new_comment_for_user = true
    else
      self.new_comment_for_adviser = true
    end
    self.save
  end

  class << self
    def ordered
      order("guest_questions.created_at DESC")
    end
  end
end

