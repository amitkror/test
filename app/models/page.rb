# == Schema Information
#
# Table name: pages
#
#  id                 :integer         not null, primary key
#  status_id          :integer         default(1)
#  page_type_id       :integer         default(1)
#  order              :integer         default(0)
#  locked             :boolean         default(FALSE)
#  in_main_nav        :boolean         default(FALSE)
#  in_sub_nav         :boolean         default(FALSE)
#  title              :string(255)     not null
#  short_title        :string(255)     default("")
#  permalink          :string(255)     not null
#  absolute_url       :string(255)     not null
#  redirect           :string(255)     default("")
#  copy               :text            default("")
#  meta_description   :text            default("")
#  teaser             :text            default("")
#  resources_title    :string(255)     default("Recommended Resources")
#  resources_subtitle :string(255)     default("")
#  ancestry_depth     :integer         default(0)
#  ancestry           :string(255)
#  gallery_id         :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

class Page < AbstractPermalink

  PAGE_TYPES = {
    'Two columns' => 1,
    Phase: 2,
    'One column' => 3,
  }

  has_ancestry orphan_strategy: :rootify, cache_depth: true

  belongs_to :gallery

  has_many :page_faqs, dependent: :destroy
  has_many :faqs, through: :page_faqs, order: "page_faqs.order"

  has_many :page_resources, dependent: :destroy
  has_many :resources, through: :page_resources, order: "page_resources.order"

  has_many :promo_connections, as: :promoable, order: "promo_connections.order"

  attr_accessible :copy, :gallery_id, :in_main_nav, :in_sub_nav,
                  :meta_description, :order, :page_faqs_attributes,
                  :page_resources_attributes, :page_type_id, :parent_id,
                  :permalink, :promo_connections_attributes, :redirect,
                  :resources_subtitle, :resources_title, :short_title,
                  :status_id, :teaser, :title

  accepts_nested_attributes_for :page_resources, allow_destroy: true
  accepts_nested_attributes_for :page_faqs, allow_destroy: true
  accepts_nested_attributes_for :promo_connections, allow_destroy: true

  validates :title, presence: true, uniqueness: { scope: :absolute_url }
  validates :absolute_url, presence: true, uniqueness: { scope: :absolute_url }

  after_validation :update_children
  before_validation :set_meta
=begin
  searchable if: :active? do

    text :title, stored: true
    text :short_title
    text :copy
    text :meta_description

    text :absolute_url, stored: true do
      absolute_url
    end
  end
=end

  def one_column?
    return self.page_type_id == 3
  end

  def phase?
    return self.page_type_id == PAGE_TYPES[:Phase]
  end

  def meta
    return self.meta_description unless self.meta_description.blank?
    return self.teaser unless self.teaser.blank?
    return self.copy unless self.copy.blank?
    ""
  end

  def promos
    pros = self.promo_connections.ordered
    if pros.length == 0
      parent = self.parent
      while pros.length == 0 && parent != nil
        pros = parent.promo_connections.ordered
        parent = parent.parent
      end
    end
    pros
  end

  private
    def make_permalink
      self.permalink = title.parameterize if permalink.blank? && !title.blank?
      self.absolute_url = "/" + self.permalink
      unless parent.nil?
        self.absolute_url = "#{parent.absolute_url}#{self.absolute_url}"
      end
    end

    def update_children
      # Save the children if your permalink changed
      if !self.new_record? && self.permalink_changed?
        self.children.each do |p|
          p.save
        end
      end
    end

    def set_meta
      self.short_title = title if self.short_title.blank?
      if self.copy_changed?
        self.copy = "" if self.copy == "<p><p>" # clean out tinymce
      end
    end

  class << self

    def exclude(id)
      where([ "pages.id != ?", id ])
    end

    def link_only
      select("pages.permalink")
    end

    def ordered
      order("in_main_nav DESC, in_sub_nav DESC, pages.order, pages.title")
    end

    def skinny
      select(["id", "short_title", "absolute_url", "ancestry", "teaser",
              "in_main_nav", "in_sub_nav"]
          .collect {|s| "pages.#{s}"}.join(","))
    end

    def super_skinny
      select(["id", "title", "permalink", "status_id", "short_title",
              "absolute_url", "ancestry", "locked"]
          .collect {|s| "pages.#{s}"}.join(","))
    end

    def update_order(page, idx, children)
      begin
        page.order = idx
        children.to_a.each do |d|
          p = Page.super_skinny.find_by_id(d['id'])
          p.parent_id = page.id unless p.locked
          update_order p, d['idx'], d['children']
        end
        page.save
      rescue Exception => e
        puts "ERROR #{e.message}"
      end
      return true
    end

    def update_tree(pages)
      pages.to_a.each do |d|
        p = Page.super_skinny.find_by_id(d['id'])
        update_order p, d['idx'], d['children']
      end
    end

  end
end
