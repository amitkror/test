class CreateFaqAudiences < ActiveRecord::Migration
  def change
    create_table :faq_audiences do |t|
      t.references :faq, null: false
      t.references :audience, null: false

      t.timestamps
    end
    add_index :faq_audiences, :faq_id
    add_index :faq_audiences, :audience_id
  end
end
