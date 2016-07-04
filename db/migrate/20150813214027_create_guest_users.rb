class CreateGuestUsers < ActiveRecord::Migration
  def change
    create_table :guest_users do |t|
      t.string :email, null: false
      t.string :zipcode
      t.string :secret_code, null: false

      t.timestamps
    end
  end
end
