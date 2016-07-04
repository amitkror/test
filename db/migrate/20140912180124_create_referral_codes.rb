class CreateReferralCodes < ActiveRecord::Migration
  def change
    create_table :referral_codes do |t|
      t.integer :contest_id, null: false
      t.integer :user_id, null: false
      t.string :code, null: false

      t.timestamps
    end

    add_index :referral_codes, [:contest_id, :user_id], unique: true
    add_index :referral_codes, :code, unique: true
  end
end
