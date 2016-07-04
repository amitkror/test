class SearchForm

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  POPULAR = [
    { name: "Expert's Pick", id: 1, class: 'expert' },
    { name: "Comments", id: 2, class: 'comments' },
    { name: "Most Helpful", id: 3, class: 'helpful' }
  ]

  OPTIONS = [
    ["Show all resources", ""],
    ["Programs", 1],
    ["Websites", 2],
    ["Videos", 3],
    ["Tutorials", 4],
    ["Documents", 5],
  ]

  attr_accessor :audience_ids, :borough_ids, :language_ids, :org, :phase_id,
                :popular_ids, :q, :subject_ids, :type

  def audience_ids
    @audience_ids || []
  end

  def borough_ids
    @borough_ids || []
  end

  def language_ids
    @language_ids || []
  end

  def organization
    return Organization.find_by_id(self.org) unless self.org.blank?
    nil
  end

  def phase
    return Phase.find_by_id(self.phase_id) unless self.phase_id.blank?
    nil
  end

  def org
    @org || nil
  end

  def popular_ids
    @popular_ids || []
  end

  def q
    @q || ""
  end

  def subject_ids
    @subject_ids || []
  end

  def type
    @type || nil
  end

  def has_audience?(audience_id)
    self.audience_ids.include?(audience_id)
  end

  def has_borough?(borough_id)
    self.borough_ids.include?(borough_id)
  end

  def has_language?(language_id)
    self.language_ids.include?(language_id)
  end

  def has_popular?(popular_id)
    self.popular_ids.include?(popular_id)
  end

  def has_subject?(subject_id)
    self.subject_ids.include?(subject_id)
  end

  def initialize(attributes={})
    if attributes.blank?
      # set the defaults
      return
    end

    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  # Do this because we're not using the db for this.
  def persisted?
    false
  end

  def params
    ps = {}
    ps[:q] = self.q unless self.q.blank?
    ps[:aud] = self.audience_ids.join(',') if self.audience_ids.any?
    ps[:bor] = self.borough_ids.join(',') if self.borough_ids.any?
    ps[:lang] = self.language_ids.join(',') if self.language_ids.any?
    ps[:pop] = self.popular_ids.join(',') if self.popular_ids.any?
    ps[:sub] = self.subject_ids.join(',') if self.subject_ids.any?
    ps[:type] = self.type unless self.type.blank?
    ps[:org] = self.org unless self.org.blank?
    ps[:phase_id] = self.phase_id unless self.phase_id.blank?
    ps
  end

  def search
    self.listings = Listing.active.skinny
  end

end
