class AddPageFaqsCountToFaqs < ActiveRecord::Migration
  def change
    add_column :faqs, :page_faqs_count, :integer, default: 0
    Faq.reset_column_information
    Faq.find(:all).each do |p|
      Faq.update_counters p.id, page_faqs_count: p.page_faqs.length
    end
  end
end
