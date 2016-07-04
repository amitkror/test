class AddColumnsToContests < ActiveRecord::Migration
  def change
    add_column :contests, :sub_text, :text
    add_column :contests, :bullet_1, :string, default: "Generate your code to begin!"
    add_column :contests, :bullet_2, :string, default: "Share your link!"
    add_column :contests, :bullet_3, :string, default: "Watch your referrals."
  end
end
