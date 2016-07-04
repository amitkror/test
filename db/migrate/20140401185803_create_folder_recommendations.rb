class CreateFolderRecommendations < ActiveRecord::Migration
  def change
    create_table :folder_recommendations do |t|
      t.references :folder
      t.text :description
      t.string :demographic

      t.timestamps
    end
    add_index :folder_recommendations, :folder_id
  end
end
