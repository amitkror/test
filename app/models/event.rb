# == Schema Information
#
# Table name: events
#
#  id                   :integer         not null, primary key
#  name                 :string(255)     not null
#  start_datetime       :datetime        not null
#  end_datetime         :datetime
#  organization         :string(255)
#  website              :string(255)
#  cost_text            :string(255)
#  contact_name         :string(255)
#  contact_email        :string(255)
#  contact_phone_number :string(255)
#  location             :string(255)
#  street               :string(255)
#  city                 :string(255)
#  state                :string(255)     default("NY")
#  postal_code          :string(255)
#  body                 :text            not null
#  logo_uid             :string(255)
#  logo_name            :string(255)
#  attachment_uid       :string(255)
#  attachment_name      :string(255)
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
#

class Event < AbstractPermalink

  image_accessor :attachment
  image_accessor :logo

  belongs_to :last_commenter, class_name: "User"

  has_many :event_boroughs
  has_many :boroughs, through: :event_boroughs, dependent: :destroy
  has_many :event_subway_lines
  has_many :subway_lines, through: :event_subway_lines, dependent: :destroy
  has_many :comments, { as: :commentable, dependent: :destroy }
  
  has_many :event_audiences, dependent: :destroy
  has_many :audiences, through: :event_audiences

  attr_accessible :attachment_label, :attachment, :body, :borough_ids, :city,
                  :contact_email, :contact_name, :contact_phone_number,
                  :cost_text, :end_datetime, :last_commented_at, :location,
                  :logo, :name, :organization, :permalink, :postal_code,
                  :remove_attachment, :remove_logo, :retained_attachment,
                  :retained_logo, :start_datetime, :state, :status_id, :street,
                  :subway_line_ids, :website, :attachment_url, :logo_url, :audience_ids

  before_validation :set_lat_long
  delegate :username, to: :last_commenter, prefix: true, allow_nil: true

  validates :name, :start_datetime, presence: true
  validates :permalink, uniqueness: true
  validates_property :width, of: :logo, in: (10..575),
    message: " should be between 10px and 575px"
  validates_size_of :attachment, maximum: 10.megabytes,
    message: " is too large. Please, no larger than 10MB"
  validates_size_of :logo, maximum: 10.megabytes,
    message: " is too large. Please, no larger than 10MB"


  def clear_boroughs
    self.event_boroughs.delete_all
  end

  def clear_subway_lines
    self.event_subway_lines.delete_all
  end

  def clear_audiences
    self.audiences.delete_all
  end  

  def full_address
    "#{self.location} #{self.street} {self.city} #{self.state} #{self.postal_code}".strip
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

  def has_borough?(borough_id)
    return self.borough_ids.include?(borough_id) if !self.new_record?
    false
  end

  def has_subway_line?(subway_line_id)
    return self.subway_line_ids.include?(subway_line_id) if !self.new_record?
    false
  end

  def has_audience?(audience_id)
    return self.audience_ids.include?(audience_id) if !self.new_record?
    false
  end

  class << self

    def by_day(date)
      start = date.beginning_of_day
      fin =  date.end_of_day
      where('(start_datetime BETWEEN ? and ?) OR (end_datetime BETWEEN ? and ?)', start, fin, start, fin)
    end

    def by_month(date)
      start = date.beginning_of_month
      fin = date.end_of_month
      where('(start_datetime BETWEEN ? and ?) OR (end_datetime BETWEEN ? and ?)', start, fin, start, fin)
    end

    def future_events(excluded_permalink)
      active.ordered.where("permalink NOT IN (?)", [excluded_permalink])
        .future.limit(3)
    end

    def future
      where('start_datetime > ? OR end_datetime > ?', DateTime.now, DateTime.now)
    end

    def ordered
      order("start_datetime ASC")
    end


    def reverse_ordered
      order("start_datetime DESC")
    end

    def skinny
      select(["id", "name", "start_datetime", "end_datetime", "location",
              "permalink"].collect{ |s| "events.#{s}"}.join(","))
    end

    def to_csv(domain)
      events = Event.ordered

      boroughs = Borough.select("id, name")
      borough_ids = boroughs.collect{ |i| i.id }


      subway_lines = SubwayLine.select("id, name")
      subway_line_ids = subway_lines.collect{ |i| i.id }

      header = ["id", "name", "created at", "updated at", "start date",
        "end date", "organization", "website", "cost", "contact name",
        "contact email", "contact phone number", "location", "street", "city",
        "state", "postal code", "body", "status", "permalink", "latitude",
        "longitude", "last commented at", "last commenter", "comments count"]

      boroughs.each do |a|
        header << a.name
      end

      subway_lines.each do |a|
        header << a.name
      end

      csv_string = CSV.generate do |csv|
        csv << header
        # data rows
        events.each do |e|
          row = [e.id, e.name, e.created_at, e.updated_at,
                 e.start_datetime, e.end_datetime, e.organization,
                 e.website, e.cost_text, e.contact_name,
                 e.contact_email, e.contact_phone_number,
                 e.location, e.street, e.city, e.state,
                 e.postal_code, e.body, e.status_s,
                 "http://#{domain}/events/#{e.permalink}", e.latitude,
                 e.longitude, e.last_commented_at, e.last_commenter_username,
                 e.comments_count]

          borough_ids.each do |a|
            row << e.has_borough?(a) ? "true" : "false"
          end

          subway_line_ids.each do |a|
            row << e.has_subway_line?(a) ? "true" : "false"
          end
          csv << row
        end
      end
      return csv_string
    end
  end
end
