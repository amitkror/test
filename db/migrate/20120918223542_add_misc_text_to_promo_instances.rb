class AddMiscTextToPromoInstances < ActiveRecord::Migration
  def change
    add_column :promo_instances, :misc_text, :string
  end
end
