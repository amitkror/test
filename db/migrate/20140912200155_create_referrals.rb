class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.integer :referrer_id, null: false
      t.integer :referred_id, null: false
      t.integer :contest_id, null: false
      
      t.timestamps
    end
    add_index :referrals, [:referrer_id, :referred_id], unique: true
  end
end
