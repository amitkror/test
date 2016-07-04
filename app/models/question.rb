# == Schema Information
#
# Table name: questions
#
#  id                      :integer         not null, primary key
#  user_id                 :integer         not null
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

class Question < ActiveRecord::Base

  belongs_to :user
  belongs_to :adviser, class_name: "User"
  belongs_to :topic, class_name: "Subject"
  belongs_to :last_commenter, class_name: "User"

  has_many :comments, { as: :commentable, dependent: :destroy }

  attr_accessible :accepts_tos, :adviser_id, :last_commented_at, :question,
                  :topic_id, :answered, :new_comment_for_user, :new_comment_for_adviser, :last_commenter_id

  delegate :email, :username, to: :adviser, prefix: true, allow_nil: true
  delegate :username, to: :last_commenter, prefix: true, allow_nil: true
  delegate :email, :username, to: :user, prefix: true
  delegate :name, to: :topic, prefix: true, allow_nil: true

  validates :user, presence: true
  validates :accepts_tos, acceptance: { accept: true }

  before_validation :check_assignee

  def assigned?
    !adviser.blank?
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
    end
    self.new_comment_for_user = false if u.id == self.user.id
    self.save
  end

  def mark_unread(u)
    if !self.adviser.blank? && u.id == self.adviser.id
      self.new_comment_for_user = true
    end
    self.new_comment_for_adviser = true if u.id == self.user.id
    self.save
  end

  class << self
    def ordered
      order("questions.created_at DESC")
    end

    def to_csv(domain)
      resources = Question.ordered

      header = ["id", "user id", "user", "topic", "created at",
        "updated at", "question", "adviser_id", "answered"]

      csv_string = CSV.generate do |csv|
        csv << header
        # data rows
        resources.each do |r|
          row = [r.id, r.user.id, r.user_username, r.topic_name,
            r.created_at, r.updated_at, r.question, r.adviser_username,
            r.answered]
          r.comments.each do |c|
            row << "#{c.user_username} on #{c.created_at}: #{c.content}"
          end

          csv << row
        end
      end
      csv_string
    end

  end
end
