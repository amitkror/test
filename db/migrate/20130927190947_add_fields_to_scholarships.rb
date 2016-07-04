class AddFieldsToScholarships < ActiveRecord::Migration
  def change
    add_column :scholarships, :high_school_label, :string
    add_column :scholarships, :or_label_text, :string
    add_column :scholarships, :description_instructions, :string
    add_column :scholarships, :title_label, :string

    add_column :scholarships, :show_upload, :boolean, default: true
    add_column :scholarships, :show_video_url, :boolean, default: true
    add_column :scholarships, :show_or_label, :boolean, default: true
    add_column :scholarships, :show_title, :boolean, default: true
  end
end
