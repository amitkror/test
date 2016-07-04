# == Schema Information
#
# Table name: resources
#
#  id                   :integer         not null, primary key
#  name                 :string(255)     not null
#  type_id              :integer         not null
#  bookmarks_count      :integer         default(0)
#  helpful_count        :integer         default(1)
#  organization_id      :integer
#  website              :string(255)
#  contact_name         :string(255)
#  contact_email        :string(255)
#  contact_phone_number :string(255)
#  street               :string(255)
#  city                 :string(255)
#  state                :string(255)     default("NY")
#  postal_code          :string(255)
#  when_text            :text
#  cost_text            :string(255)
#  size_text            :string(255)
#  is_experts_pick      :boolean
#  conditions_of_use_id :integer
#  body                 :text
#  teaser               :text            default("")
#  logo_uid             :string(255)
#  logo_name            :string(255)
#  attachment_label     :string(255)
#  status_id            :integer         default(1)
#  permalink            :string(255)     not null
#  latitude             :float
#  longitude            :float
#  last_commented_at    :datetime
#  last_commenter_id    :integer
#  comments_count       :integer         default(0)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  last_editor_id       :integer
#  keywords             :text            default("")
#

class Resource < AbstractPermalink

  include ActionView::Helpers::TextHelper

  # Vendor attributes
  image_accessor :logo

  # Public hashes
  STATUSES = {
    Published: 1,
    Unpublished: 2,
    Hidden: 3,
    Suggested: 4,
  }

  TYPES = {
    program: 1,
    website: 2,
    video: 3,
    tutorial: 4,
    document: 5,
  }

  # Relations
  belongs_to :conditions_of_use
  belongs_to :last_commenter, class_name: "User"
  belongs_to :last_editor, class_name: "User"
  belongs_to :organization, counter_cache:true
  belongs_to :new_organization, class_name: "Organization", counter_cache:true

  has_many :resource_audiences, dependent: :destroy
  has_many :audiences, through: :resource_audiences

  has_many :resource_assets, dependent: :destroy, order: "resource_assets.order"
  has_many :assets, through: :resource_assets, order: "resource_assets.order"

  has_many :resource_boroughs, dependent: :destroy
  has_many :boroughs, through: :resource_boroughs

  has_many :comments, { as: :commentable, dependent: :destroy }

  has_many :resource_languages, dependent: :destroy
  has_many :languages, through: :resource_languages

  has_many :resource_phases, dependent: :destroy
  has_many :phases, through: :resource_phases

  has_many :resource_subjects, dependent: :destroy
  has_many :subjects, through: :resource_subjects

  has_many :resource_subway_lines, dependent: :destroy
  has_many :subway_lines, through: :resource_subway_lines

  has_many :resource_supports, dependent: :destroy
  has_many :supports, through: :resource_supports

  has_many :user_resources, dependent: :destroy
  has_many :users, through: :user_resources

  has_many :bookmarks, dependent: :destroy

  # Attribute availability
  attr_accessible :attachment_label, :assets_attributes, :audience_ids, :body,
                  :borough_ids, :city, :contact_email, :contact_name,
                  :conditions_of_use_id, :contact_phone_number, :cost_text,
                  :helpful_count, :is_experts_pick, :keywords,
                  :last_commented_at, :language_ids, :logo, :name,
                  :organization_id, :new_organization_attributes, :permalink,
                  :phase_ids, :postal_code, :retained_logo, :remove_logo,
                  :size_text, :state, :status_id, :street, :subject_ids,
                  :subway_line_ids, :support_ids, :teaser, :type_id,
                  :user_tokens, :website, :when_text, :logo_url
  attr_reader :user_tokens

  # Delegates
  delegate :name, :rando_resources, :type_s, to: :organization, prefix: true,
            allow_nil: true
  delegate :copy, :title, to: :conditions_of_use, prefix: true, allow_nil: true
  delegate :username, to: :last_commenter, prefix: true, allow_nil: true
  delegate :username, to: :last_editor, prefix: true, allow_nil: true

  # Nested attributes
  accepts_nested_attributes_for :assets, reject_if: lambda { |o|
    o[:title].blank? }, allow_destroy: true
  accepts_nested_attributes_for :new_organization, reject_if: lambda { |o|
    o[:name].blank? }

  # Validations
  validates :name, :type_id, presence: true
  validates :permalink, uniqueness: true
  validates :name, :website, :contact_name, :contact_email,
            :contact_phone_number, :street, :city, :state, :postal_code,
            :cost_text, :size_text, :logo_name, :attachment_label,
            :permalink, length: { maximum: 255 }
  validates_size_of :logo, maximum: 10.megabytes,
    message: " is too large. Please, no larger than 10MB"

  # Event hooks
  after_create :set_asset_order
  after_save :set_asset_order
  before_validation :set_lat_long
  before_save :set_organization
  before_validation :set_last_editor

  # Search
  searchable if: :active? do

    text :name
    text :keywords
    text :body
    text :teaser

    integer :type_id
    integer :organization_id
    integer :audience_ids, multiple: true
    integer :borough_ids, multiple: true
    integer :language_ids, multiple: true
    integer :phase_ids, multiple: true
    integer :subject_ids, multiple: true

    string :sort_name do
      name.downcase.gsub(/^("|an?|the\ )\b/, '').strip
    end

    integer :popular_ids, multiple: true do
      ids = []
      ids << 1 if self.is_experts_pick
      ids << 2 if self.has_comments?
      ids << 3 if self.most_helpful?
      ids
    end
  end

  # Methods and properties

  self.per_page = 10

  def clear_audiences
    self.resource_audiences.delete_all
  end

  def clear_boroughs
    self.resource_boroughs.delete_all
  end

  def clear_languages
    self.resource_languages.delete_all
  end

  def clear_phases
    self.resource_phases.delete_all
  end

  def clear_subjects
    self.resource_subjects.delete_all
  end

  def clear_subway_lines
    self.resource_subway_lines.delete_all
  end

  def clear_supports
    self.resource_supports.delete_all
  end

  def full_address
    "#{self.street} #{self.city} #{self.state} #{self.postal_code}".strip
  end

  def has_comments?
    self.comments.any?
  end

  def has_audience?(audience_id)
    return self.audience_ids.include?(audience_id) if !self.new_record?
    false
  end

  def has_borough?(borough_id)
    return self.borough_ids.include?(borough_id) if !self.new_record?
    false
  end

  def has_language?(language_id)
    return self.language_ids.include?(language_id) if !self.new_record?
    false
  end

  def has_phase?(phase_id)
    return self.phase_ids.include?(phase_id) if !self.new_record?
    false
  end

  def has_subject?(subject_id)
    return self.subject_ids.include?(subject_id) if !self.new_record?
    false
  end

  def has_support?(support_id)
    return self.support_ids.include?(support_id) if !self.new_record?
    false
  end

  def has_subway_line?(subway_line_id)
    return self.subway_line_ids.include?(subway_line_id) if !self.new_record?
    false
  end

  def helpful_key
    "resource-#{self.id}"
  end

  def most_helpful?
    self.helpful_count > 1
  end

  def set_lat_long
    return nil if full_address.blank?
    return nil unless (self.street_changed? || self.city_changed? ||\
      self.state_changed? || self.postal_code_changed?)

    begin
      url = "http://maps.googleapis.com/maps/api/geocode/json?"\
            "sensor=false&address="
      url << [self.street, self.city, self.state,
              self.postal_code].join(",").gsub(' ', '+')
      res = JSON.parse(open(url).read)
      ll = res['results'][0]['geometry']['location']
      self.latitude = ll['lat']
      self.longitude = ll['lng']
    rescue Exception => e

      logger.error e.message
      self.errors[:latitude] << " > cannot get latitude for that address"
      self.errors[:longitude] << " > cannot get longitude for that address"
    end

  end

  def set_organization
    unless self.new_organization.blank?
      self.new_organization.save
      self.organization = self.new_organization
      self.new_organization = nil
    end
    true
  end

  def set_last_editor
    self.last_editor = User.current
  end

  def status_s
    STATUSES.find{|key, hash| hash == self.status_id }.first.to_s
  end

  def teaser_or_body
    if self.teaser.blank?
      return truncate(strip_tags(self.body), length: 150, separator: ' ')
    end
    self.teaser
  end

  def type_s
    TYPES.find{|key, hash| hash == self.type_id }.first.to_s
  end

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end

  private

    def set_asset_order
      puts "-------------------"
      puts "SET ASSET ORDER #{self.resource_assets.collect{|p| p.id }}"
      puts "#{self.assets.collect{|p| p.id }}"
      resource_asset = nil
      self.assets.each_with_index do |a, idx|
        resource_asset = self.resource_assets[idx]
        resource_asset.order = a.order
        resource_asset.save
        puts "+save it! ORDER resource_asset #{resource_asset.id} #{a.id } #{a.order}, #{a.title}"
        puts "#{resource_asset.order}"
      end
      puts "-------------------"
    end

  # Class methods
  class << self

    def ordered
      order("resources.name")
    end

    def recent
      order("resources.updated_at DESC, resources.created_at DESC")
    end

    def suggested
      where(status_id: STATUSES[:Suggested])
    end

    def super_skinny
      select(["id", "name"]
          .collect {|s| "resources.#{s}"}.join(","))
    end

    def skinny
      select(["id", "name", "teaser", "type_id", "permalink"]
          .collect {|s| "resources.#{s}"}.join(","))
    end

    def top_saved
      select("permalink, name").order("bookmarks_count DESC").limit(3)
    end

    def to_csv(domain)
      resources = Resource.ordered

      audiences = Audience.ordered.select("id, name")
      audience_ids = audiences.collect{ |a| a.id }

      boroughs = Borough.select("id, name")
      borough_ids = boroughs.collect{ |i| i.id }

      languages = Language.select("id, name")
      language_ids = languages.collect{ |i| i.id }

      phases = Phase.select("id, name")
      phase_ids = phases.collect{ |i| i.id }

      subjects = Subject.select("id, name")
      subject_ids = subjects.collect{ |i| i.id }

      subway_lines = SubwayLine.select("id, name")
      subway_line_ids = subway_lines.collect{ |i| i.id }

      supports = Support.select("id, name")
      support_ids = supports.collect{ |i| i.id }

      header = ["id", "name", "type", "created at", "updated at",
        "bookmarks count", "helpful count",
        "organization", "website", "contact name", "contact email",
        "contact phone number", "street", "city", "state", "postal code",
        "when text", "cost text", "size text", "is experts pick",
        "conditions of use", "body", "teaser", "attachment label",
        "status", "permalink", "latitude", "longitude", "last commented at",
        "last commenter", "comments count"]

      audiences.each do |a|
        header << a.name
      end

      boroughs.each do |a|
        header << a.name
      end

      languages.each do |a|
        header << a.name
      end

      phases.each do |a|
        header << a.name
      end

      subjects.each do |a|
        header << a.name
      end

      subway_lines.each do |a|
        header << a.name
      end

      supports.each do |a|
        header << a.name
      end

      csv_string = CSV.generate do |csv|
        csv << header
        # data rows
        resources.each do |r|
          row = [r.id, r.name, r.type_s, r.created_at, r.updated_at,
            r.bookmarks_count, r.helpful_count, r.organization_name, r.website,
            r.contact_name, r.contact_email, r.contact_phone_number, r.street,
            r.city, r.state, r.postal_code, r.when_text, r.cost_text,
            r.size_text, r.is_experts_pick, r.conditions_of_use_title,
            r.body, r.teaser, r.attachment_label,
            r.status_s, "http://#{domain}/resources/#{r.permalink}", r.latitude,
            r.longitude, r.last_commented_at,
            r.last_commenter_username, r.comments_count]

          audience_ids.each do |a|
            row << r.has_audience?(a) ? "true" : "false"
          end

          borough_ids.each do |a|
            row << r.has_borough?(a) ? "true" : "false"
          end

          language_ids.each do |a|
            row << r.has_language?(a) ? "true" : "false"
          end

          phase_ids.each do |a|
            row << r.has_phase?(a) ? "true" : "false"
          end

          subject_ids.each do |a|
            row << r.has_subject?(a) ? "true" : "false"
          end

          subway_line_ids.each do |a|
            row << r.has_subway_line?(a) ? "true" : "false"
          end

          support_ids.each do |a|
            row << r.has_support?(a) ? "true" : "false"
          end

          csv << row
        end
      end
      csv_string
    end

    def updated_today
      where(updated_at: Time.now.all_day)
    end

  end

end
