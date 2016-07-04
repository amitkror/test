# The Subclass must have a unique string `permalink` property and a
# string property `title` or `name`.

class AbstractPermalink < Abstract

  self.abstract_class = true

  validates :permalink, presence: true

  before_validation :make_permalink

  def to_param
    return self.permalink
  end

  private
    def make_permalink

      unless permalink.blank?
        check_integer
        return true
      end

      if self.attributes.has_key? 'title'
        self.permalink = self.title.parameterize unless self.title.blank?
      elsif self.attributes.has_key? 'name'
        self.permalink = self.name.parameterize unless self.name.blank?
      end

      check_integer

    end

    def check_integer
      # check to see if it's an integer and make it not one
      self.permalink = "_#{self.permalink }" if !!(self.permalink =~ /^[-+]?[0-9]+$/)
    end
end
