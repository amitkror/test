# == Schema Information
#
# Table name: faqs
#
#  id              :integer         not null, primary key
#  question        :text            not null
#  answer          :text            not null
#  status_id       :integer         default(1)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  page_faqs_count :integer         default(0)
#

class Faq < Abstract

  has_many :page_faqs, dependent: :destroy
  has_many :pages, through: :page_faqs, order: "page_faqs.order"
  
  has_many :faq_audiences, dependent: :destroy
  has_many :audiences, through: :faq_audiences


  attr_accessible :answer, :question, :status_id, :audience_ids

  validates :answer, :question, presence: true

  def has_audience?(audience_id)
    return self.audience_ids.include?(audience_id) if !self.new_record?
    false
  end

  def clear_audiences
    self.audiences.delete_all
  end  

  class << self

    def ordered
      order("faqs.question")
    end

    def orphans
      where("page_faqs_count = 0")
    end

    def super_skinny
      select(["id", "question"]
          .collect {|s| "faqs.#{s}"}.join(","))
    end

    def to_csv
      faqs = Faq.ordered

      csv_string = CSV.generate do |csv|
        csv << ["id", "question", "answer", "status"]
        faqs.each do |faq|
          csv << [faq.id, faq.question, faq.answer, faq.status_s]
        end
      end

      csv_string
    end
  end

end
