# The Subclass must have a numeric `status_id` property.

class Abstract < ActiveRecord::Base

  self.abstract_class = true

  STATUSES = {
    Published: 1,
    Unpublished: 2,
    Hidden: 3,
  }

  def active?
    self.status_id == STATUSES[:Published]
  end

  def hidden?
    self.status_id == STATUSES[:Hidden]
  end

  def status_s
    STATUSES.find{|key, hash| hash == self.status_id }.first.to_s
  end

  def unpublished?
    self.status_id == STATUSES[:Unpublished]
  end

  class << self

    def active
      where(status_id: STATUSES[:Published])
    end

    def active_or_hidden
      where("status_id IN (?, ?)", STATUSES[:Hidden], STATUSES[:Published])
    end
  end
end
