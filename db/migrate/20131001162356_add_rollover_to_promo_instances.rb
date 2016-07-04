class AddRolloverToPromoInstances < ActiveRecord::Migration
  def change
    add_column :promo_instances, :rollover_uid, :string
    add_column :promo_instances, :rollover_name, :string
  end
end
