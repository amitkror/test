class CreatePromoConnections < ActiveRecord::Migration
  def change
    create_table :promo_connections do |t|
      t.integer :order, default: 0
      t.references :promo_instance
      t.references :promoable, polymorphic: true

      t.timestamps
    end
    add_index :promo_connections, :promo_instance_id
    add_index :promo_connections, [:promoable_id, :promoable_type]
  end
end
