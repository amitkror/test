class AddColumnToContests < ActiveRecord::Migration
  def change
    add_column :contests, :generate_text, :string, default: "Generate your code to begin!"
  end
end
