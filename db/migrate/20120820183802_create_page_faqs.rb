class CreatePageFaqs < ActiveRecord::Migration
  def change
    create_table :page_faqs do |t|
      t.references :page
      t.references :faq
      t.integer :order

      t.timestamps
    end
    add_index :page_faqs, :page_id
    add_index :page_faqs, :faq_id
  end
end
