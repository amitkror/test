# == Schema Information
#
# Table name: scholarship_submissions
#
#  id                          :integer         not null, primary key
#  first_name                  :string(255)     default(""), not null
#  last_name                   :string(255)     default(""), not null
#  high_school                 :string(255)     default(""), not null
#  year_in_school              :string(255)     default(""), not null
#  email                       :string(255)     default(""), not null
#  phone                       :string(255)     default(""), not null
#  state                       :string(255)     default(""), not null
#  birth_month                 :string(255)     default(""), not null
#  birth_year                  :string(255)     default(""), not null
#  not_currently_enrolled      :boolean
#  of_age_or_consent           :boolean
#  document_uid                :string(255)
#  document_name               :string(255)
#  video_url                   :string(255)     default("")
#  description                 :text
#  agree_to_terms              :boolean
#  scholarship_id              :integer         not null
#  created_at                  :datetime        not null
#  updated_at                  :datetime        not null
#  submission_format           :text            default("")
#  submission_prompt           :text            default("")
#  video_embed                 :text
#  thumbnail_uid               :string(255)
#  thumbnail_name              :string(255)
#  selected_entry              :boolean         default(FALSE)
#  user_submission_votes_count :integer         default(0)
#  school_type_id              :integer         default(0)
#  title                       :string(255)
#  order                       :integer         default(0)
#

class ScholarshipSubmission < ActiveRecord::Base

  SCHOOL_TYPES = {
    'Not specified' => 1,
    'High school' => 1,
    'College' => 2,
  }

  # Vendor attributes
  image_accessor :document
  image_accessor :thumbnail

  # Relations
  belongs_to :scholarship
  has_many :user_submission_votes, dependent: :destroy

  # Attribute availability
  attr_accessible :agree_to_terms, :birth_month, :birth_year, :description,
                  :document, :email, :first_name, :high_school, :last_name,
                  :not_currently_enrolled, :of_age_or_consent, :phone,
                  :scholarship_id, :state, :video_url, :year_in_school,
                  :retained_document, :remove_document, :submission_format,
                  :submission_prompt, :video_embed, :thumbnail, :selected_entry,
                  :retained_thumbnail, :remove_thumbnail, :school_type_id,
                  :title, :order, :thumbnail_url
  # Validations
  validates :agree_to_terms, :birth_month, :birth_year, :description,
            :email, :first_name, :high_school, :last_name,
            :of_age_or_consent, :phone, :scholarship, :state,
            :year_in_school, :submission_format, :submission_prompt,
            presence: true
  validates :agree_to_terms, :birth_month, :birth_year,
            :document_name, :email, :first_name, :high_school, :last_name,
            :phone, :state, :video_url, :year_in_school,
            length: { maximum: 255 }

  validates_size_of :document, maximum: 10.megabytes,
    message: " is too large. Please, no larger than 10MB"

  # Delegates
  delegate :name, to: :scholarship, prefix: true, allow_nil: true

  def full_name
    "#{self.first_name} #{self.last_name}".chomp(" ")
  end

  def full_document_url
    return "" if self.document_uid.blank?
    self.document.remote_url.gsub('http://http://', 'http://')
  end

  def populate(user)
    self.email = user.email
  end

  def school_type_s
    school_type = SCHOOL_TYPES.find{|key, hash| hash == self.school_type_id }
    return SCHOOL_TYPES.first[0] if school_type.blank?
    school_type.first.to_s
  end

  # Class methods
  class << self

    def ordered
      order("scholarship_submissions.created_at")
    end

    def selected
      where(selected_entry: true)
        .order(["order", "first_name", "created_at"]
          .collect {|s| "scholarship_submissions.#{s}"}.join(","))
    end

    def skinny
      select(["id", "first_name", "last_name"]
          .collect {|s| "scholarship_submissions.#{s}"}.join(","))
    end

    def to_csv(domain, scholarship_id=nil)
      submissions = ScholarshipSubmission.ordered
      unless scholarship_id.blank?
        submissions = submissions.where(scholarship_id: scholarship_id)
      end

      header = [
        'id',
        'scholarship',
        'first name',
        'last name',
        'email',
        'phone',
        'state',
        'high school',
        'year in school',
        'birth month',
        'birth year',
        'format',
        'prompt',
        'not currently enrolled',
        'description',
        'document',
        'video URL',
        'of age or consent',
        'agree to terms',
        'selected entry',
        'votes',
        'school type',
        'title',
        'video_embed',
        'thumbnail'
      ]

       csv_string = CSV.generate do |csv|
        csv << header
        # data rows
        submissions.each do |s|
          row = [
            s.id,
            s.scholarship_name,
            s.first_name,
            s.last_name,
            s.email,
            s.phone,
            s.state,
            s.high_school,
            s.year_in_school,
            s.birth_month,
            s.birth_year,
            s.submission_format,
            s.submission_prompt,
            s.not_currently_enrolled,
            s.description,
            s.document_uid.blank? ? "" : "#{s.full_document_url}",
            s.video_url,
            s.of_age_or_consent,
            s.agree_to_terms,
            s.selected_entry,
            s.user_submission_votes_count,
            s.school_type_s,
            s.title,
            s.video_embed,
            s.thumbnail_uid.blank? ? "" : "#{s.thumbnail.remote_url.gsub('http://http://', 'http://')}",]

          csv << row
        end
      end
      csv_string
    end
  end

end
