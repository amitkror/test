# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer         default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  username               :string(255)     default(""), not null
#  status_id              :integer         default(2)
#  role_id                :integer         default(1), not null
#  custom_avatar_uid      :string(255)
#  custom_avatar_name     :string(255)
#  is_adviser             :boolean         default(FALSE)
#  accepts_tos            :boolean         default(TRUE)
#  set_up_profile         :boolean         default(FALSE)
#  verified_type_id       :integer         default(0)
#  system_avatar_id       :integer
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  borough_id             :integer
#  zipcode                :string(255)
#  bio                    :text
#  from_guest_user        :boolean
#

require 'csv'

class User < Abstract

  # Include default devise modules. Others available are:
  # :token_authenticatable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]
  image_accessor :custom_avatar

  ROLES = {
    User: 1,
    Verified: 2,
    Administrator: 3,
    Blogger: 4,
    Intern: 5,
  }
  STATUSES = {
    Inactive: 1,
    Active: 2,
  }
  VERIFIED_TYPES = {
    "verified adviser" => 1,
    "verified program" => 2,
  }

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_resources, through: :bookmarks, source: :resource
  has_many :comments, dependent: :destroy
  has_many :folders, dependent: :destroy
  has_many :forum_threads, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :adviser_questions, class_name: 'Question', foreign_key: "adviser_id"
  has_many :adviser_guest_questions, class_name: 'GuestQuestion', foreign_key: "adviser_id"
  has_many :resource_suggestions, dependent: :destroy

  has_many :blog_posts

  has_many :user_audiences, dependent: :destroy
  has_many :audiences, through: :user_audiences

  has_many :user_newsletters, dependent: :destroy
  has_many :newsletters, through: :user_newsletters

  has_many :user_resources, dependent: :destroy
  has_many :resources, through: :user_resources

  has_one :user_settings
  belongs_to :borough
  belongs_to :system_avatar

  has_many :referral_codes
  has_many :referrals, class_name: "Referral", foreign_key: "referrer_id"
  has_many :referred, through: :referrals, source: :referred

  has_one :referral, class_name: "Referral", foreign_key: "referred_id"
  has_many :contests, through: :referral_codes, source: :contest

  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :accepts_tos, :audience_ids, :borough_id, :custom_avatar,
                  :email, :is_adviser, :login, :newsletter_ids, :password,
                  :password_confirmation, :remember_me, :remove_custom_avatar,
                  :resource_tokens, :retained_custom_avatar, :role_id,
                  :set_up_profile, :status_id, :system_avatar_id, :username,
                  :verified_type_id, :user_settings_attributes, :zipcode,
                  :user_audiences_attributes, :bio, :custom_avatar_url, :from_guest_user

  attr_reader :resource_tokens

  # Delegates
  delegate :name, to: :borough, prefix: true, allow_nil: true

  accepts_nested_attributes_for :user_settings
  accepts_nested_attributes_for :user_audiences, allow_destroy: true,
    reject_if: proc { |attributes| attributes['_keep'].blank? && attributes['_keep'] != "1" }

  validates :username, presence: true, uniqueness: { scope: :username },
    length: { maximum: 50 }
  validates :accepts_tos, acceptance: { accept: true }
  validates_size_of :custom_avatar, maximum: 1.megabytes,
    message: " is too large. Please, no larger than 1MB"

  before_create :create_defaults
  before_create :set_guest_bool

  after_save :check_email_change
  after_save :swap_questions_if_guest

  def set_guest_bool
    user_email = self.email
    guest_user = GuestUser.where(email: user_email).first
    return unless guest_user

    self.from_guest_user = true
  end

  def swap_questions_if_guest
    user_email = self.email
    guest_user = GuestUser.where(email: user_email).first
    return unless guest_user

    guest_user.guest_questions.each do |guest_question|
      gu_attributes = guest_question.attributes.except('id', 'guest_user_id',
                                                       'new_for_adviser',
                                                       'comments_count', 'created_at', 'updated_at')
      question = self.questions.build(gu_attributes)
      question.user = self
      question.save

      guest_question.comments.each do |guest_comment|
        gc_attributes = guest_comment.attributes.except('id', 'commentable', 'commentable_type', 'commentable_id', 'created_at', 'updated_at')
        comment = question.comments.build(gc_attributes)
        comment.commentable = question
        unless comment.guest_user_id.blank?
          comment.user = self
          comment.guest_user_id = nil
        end
        comment.save
      end
    end

    guest_user.guest_questions.each { |gq| gq.destroy }
    guest_user.destroy
  end

  def is_entrant?(cid)
    !ReferralCode.where({ user_id: self.id, contest_id: cid }).empty?
  end

  def referral_code(cid)
    ref_code = ReferralCode.where({ user_id: self.id, contest_id: cid })
    if !ref_code.empty?
      return ref_code.first.code
    end
  end

  def avatar
    return self.custom_avatar unless self.custom_avatar_uid.blank?
    return self.system_avatar.image unless self.system_avatar.blank?
    ""
  end

  def has_audience?(audience_id)
    return self.audience_ids.include?(audience_id) if !self.new_record?
    false
  end

  def has_newsletter?(newsletter_id)
    return self.newsletter_ids.include?(newsletter_id) if !self.new_record?
    false
  end

  # def has_user_text?
  #   self.user_audiences.has_user_text?
  # end

  def resource_tokens=(ids)
    self.resource_ids = ids.split(",")
  end

  def check_email_change
  end

  def clear_audiences
    self.user_audiences.delete_all
  end

  def clear_newsletters
    self.user_newsletters.delete_all
  end

  def create_defaults
    self.folders << Folder.new({ name: "My folder" })
    self.system_avatar = SystemAvatar.ordered.first if self.system_avatar.blank?
    self.user_settings = UserSettings.new if self.user_settings.blank?
  end

  def full_name
    self.username
  end

  def send_raffle?(contest)
    ref_count = self.referrals.where({ contest_id: contest.id }).count
    if ref_count > 0 && (ref_count % contest.email_trigger_count) == 0
      self.send_raffle_invite(contest)
    end
  end

  def send_raffle_invite(contest)
    RaffleMailer.delay(queue: 'raffle-invite').send_invite(self, contest)
  end

  def send_daily_digests
    today = Time.now.all_day

    updated_ids = self.bookmarked_resources\
      .where(updated_at: today).pluck('resources.id')

    commented_ids = self.bookmarked_resources\
      .where(last_commented_at: today).pluck('resources.id')

    thread_ids = self.forum_threads\
      .where(last_commented_at: today).pluck('forum_threads.id')

    #logger.error "---\n\nupdated: #{updated_ids} commented: #{commented_ids}
    #threads: #{thread_ids} #{updated_ids.any? || commented_ids.any? ||
    #thread_ids.any?}\n\n---"

    unless updated_ids.any? || commented_ids.any? || thread_ids.any?
      return true
    end

    DailyMailer.delay(queue: 'digest').send_digest(self.id, updated_ids,
      commented_ids, thread_ids)
  end

  def admin?
    role_id == ROLES[:Administrator]
  end

  def verified?
    role_id == ROLES[:Verified] || self.admin?
  end

  def blogger?
    role_id == ROLES[:Blogger]
  end

  def intern?
    role_id == ROLES[:Intern]
  end

  def active_for_authentication?
    super && status_id == STATUSES[:Active]
  end

  def has_bookmark?(resource_id)
    self.bookmarks.where(resource_id: resource_id).exists?
  end

  def role_s
    ROLES.find{|key, hash| hash == self.role_id }.first.to_s
  end

  def status_s
    STATUSES.find{|key, hash| hash == self.status_id }.first.to_s
  end

  def to_csv_row(headers, audiences, newsletters)

    newsletter_ids = newsletters.pluck('id')

    row = [
      self.id, self.username, self.email, self.sign_in_count,
      self.last_sign_in_at, self.status_s, self.role_s,
      self.is_adviser, self.created_at, self.borough_name,
      self.zipcode
    ]

    user_audiences = self.user_audiences

    audiences.each do |a|

      user_audience = user_audiences.select do |ua|
        ua.audience_id == a.id
      end.first

      row << !user_audience.blank? ? "true" : "false"

      if a.display_user_text
        row << (user_audience.blank? ? "" : user_audience.user_text)
      end
    end

    newsletter_ids.each do |n|
      row << self.has_newsletter?(n) ? "true" : "false"
    end

    CSV::Row.new(headers, row)
  end

  def verified_type_s
    VERIFIED_TYPES.find{|key, hash| hash == self.verified_type_id }.first.to_s
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions)
      .where(["lower(username) = :value OR lower(email) = :value", {
        value: login.downcase
      }]).first
    else
      where(conditions).first
    end
  end

  protected
    def password_required?
      !persisted? || password.present? || password_confirmation.present?
    end

  class << self

    def subscribed_to_digests
      joins(:user_settings)
      .where("user_settings.notify_folder_update = true OR user_settings.notify_thread_comments = true OR user_settings.notify_resource_comments = true")
      .select(["id", "username", "email"]
              .collect {|s| "users.#{s}"}.join(","))
    end

    def advisers
      admin_or_verified.where(is_adviser: true)
    end

    def admin_or_verified
      where("role_id IN (?, ?)", ROLES[:Verified], ROLES[:Administrator])
    end

    def admins
      where("role_id IN (?)", ROLES[:Administrator])
    end

    def current
      Thread.current[:user]
    end

    def current=(user)
      Thread.current[:user] = user
    end

    def ordered
      order("users.username")
    end

    def super_skinny
      select(["id", "username"]
          .collect {|s| "users.#{s}"}.join(","))
    end

    def header(audiences, newsletters)
      header = [
        :id, :username, :email, :sign_in_count, :last_sign_in_at, :status_s,
        :role_s, :is_adviser, :created_at, :borough_name, :zipcode
      ]

      audiences.each do |a|
        header << a.name

        if a.display_user_text
          header << a.placeholder_text
        end
      end

      newsletters.each do |n|
        header << n.name
      end

      header
    end


    def to_csv
      users = User.ordered
      audiences = Audience.ordered.select("id, name, placeholder_text, display_user_text")
      newsletters = Newsletter.active.select("id, name")
      newsletter_ids = newsletters.pluck('id')

      header = ["id", "username", "email", "sign in count", "last sign in",
                "status", "role", "is adviser", "sign up", "borough", "zip code"]

      audiences.each do |a|
        header << a.name
        header << a.placeholder_text if a.display_user_text
      end

      newsletters.each do |n|
        header << n.name
      end

      csv_string = CSV.generate do |csv|
        csv << header
        # data rows
        users.each do |user|
          row = [user.id, user.username, user.email, user.sign_in_count,
                 user.last_sign_in_at, user.status_s, user.role_s,
                 user.is_adviser, user.created_at, user.borough_name,
                 user.zipcode]

          user_audiences = user.user_audiences

          audiences.each do |a|

            user_audience = user_audiences.select do |ua|
              ua.audience_id == a.id
            end.first

            row << !user_audience.blank? ? "true" : "false"

            if a.display_user_text
              row << user_audience.blank? ? "" : user_audience.user_text
            end
          end

          newsletter_ids.each do |n|
            row << user.has_newsletter?(n) ? "true" : "false"
          end
          csv << row
        end
      end
      return csv_string
    end
  end
end
