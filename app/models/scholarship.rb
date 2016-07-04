# == Schema Information
#
# Table name: scholarships
#
#  id                       :integer         not null, primary key
#  name                     :string(255)     default(""), not null
#  status_id                :integer         default(1), not null
#  end_date                 :datetime        not null
#  copy                     :text            default("")
#  terms                    :text            default("")
#  meta_description         :text
#  permalink                :string(255)     not null
#  created_at               :datetime        not null
#  updated_at               :datetime        not null
#  submission_format        :text            default("")
#  submission_prompt        :text            default("")
#  thank_you                :text            default("")
#  voting_start_date        :datetime
#  voting_end_date          :datetime
#  voting_title             :string(255)     default("Vote for the winner")
#  voting_copy              :text
#  high_school_label        :string(255)
#  or_label_text            :string(255)
#  description_instructions :string(255)
#  title_label              :string(255)
#  show_upload              :boolean         default(TRUE)
#  show_video_url           :boolean         default(TRUE)
#  show_or_label            :boolean         default(TRUE)
#  show_title               :boolean         default(TRUE)
#  require_authentication   :boolean         default(FALSE)
#  logged_in_copy           :text
#

class Scholarship < AbstractPermalink

  # Relations
  has_many :scholarship_submissions, dependent: :destroy

  has_many :scholarship_audiences, dependent: :destroy
  has_many :audiences, through: :scholarship_audiences

  # Attribute availability
  attr_accessible :copy, :end_date, :meta_description, :name, :permalink,
                  :status_id, :terms, :submission_format, :submission_prompt,
                  :thank_you, :voting_start_date, :voting_end_date,
                  :voting_title, :voting_copy,
                  :high_school_label, :show_or_label, :or_label_text,
                  :show_upload, :show_video_url, :description_instructions,
                  :show_title, :title_label, :require_authentication,
                  :logged_in_copy, :audience_ids
  # Validations
  validates :name, :status_id, :end_date, :copy, :thank_you, :submission_format,
            :submission_prompt, :high_school_label, :description_instructions,
            presence: true

  after_initialize :init

  def has_audience?(audience_id)
    return self.audience_ids.include?(audience_id) if !self.new_record?
    false
  end

  def clear_audiences
    self.audiences.delete_all
  end  

  def init
    self.end_date ||= DateTime.now + 1.month
    self.high_school_label ||= "High School/College you Attend"
    self.or_label_text ||= "OR If you are not currently enrolled in school but plan to enroll for Fall check this box"
    self.description_instructions ||= "100 word description of your entry"
  end

  def meta
    return self.meta_description unless self.meta_description.blank?
    return self.copy unless self.copy.blank?
    ""
  end

  def over?
    self.end_date < DateTime.now
  end

  def voting?
    return false if self.voting_start_date.blank?
    now = DateTime.now
    self.voting_start_date <= now && (self.voting_end_date.blank? || self.voting_end_date >= now)
  end

  # Class methods
  class << self

    def ordered
      order("scholarships.name")
    end

    def skinny
      select([
        'id', 'name', 'status_id', 'permalink', 'end_date',
        'high_school_label', 'or_label_text', 'description_instructions'
        ].collect {|s| "scholarships.#{s}"}.join(","))
    end
  end
end
