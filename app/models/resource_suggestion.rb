# == Schema Information
#
# Table name: resource_suggestions
#
#  id              :integer         not null, primary key
#  user_id         :integer         not null
#  type_id         :integer
#  attachment_uid  :string(255)
#  attachment_name :string(255)
#  link            :string(255)
#  title           :string(255)
#  description     :text
#  accepts_tos     :boolean
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  was_used        :boolean         default(FALSE)
#

class ResourceSuggestion < ActiveRecord::Base

  file_accessor :attachment

  TYPES = Resource::TYPES.merge({
    event: 6,
  })

  belongs_to :user
  belongs_to :type

  attr_accessible :accepts_tos, :attachment, :description, :link,
                  :retained_attachment, :title, :type_id, :was_used

  delegate :username, to: :user, prefix: true, allow_nil: true

  validates :title, :description, presence: true
  validates :link, :title, length: { maximum: 255 }
  validates :accepts_tos, acceptance: { accept: true }
  validates_property :format, of: :attachment, in: [:doc, :docx, :pdf, :ppt, :pptx]
  # we should really be testing for mime types, but they seem to have issues
  #validates_property :mime_type, of: :attachment, in: %w(application/pdf
  # application/msword application/vnd.ms-excel), :case_sensitive => false
  validates_size_of :attachment, maximum: 5.megabytes,
    message: " is too large. Please, no larger than 5MB"

  def type_s
    begin
      return TYPES.find{|key, hash| hash == self.type_id }.first.to_s
    rescue
      logger.error "No type to be found #{self.type_id}"
    end
    ""
  end

  class << self
    def ordered
      order("resource_suggestions.created_at DESC")
    end

    def to_csv(domain)
      resources = ResourceSuggestion.ordered

      header = ["id", "user id", "user", "title", "type", "created at",
        "updated at", "was_used", "link", "description", "attachment_uid",
        "attachment_name"]

      csv_string = CSV.generate do |csv|
        csv << header
        # data rows
        resources.each do |r|
          row = [r.id, r.user.id, r.user_username, r.title, r.type_s,
            r.created_at, r.updated_at, r.was_used, r.link, r.description,
            r.attachment_uid, r.attachment_name]

          csv << row
        end
      end
      csv_string
    end
  end

end
