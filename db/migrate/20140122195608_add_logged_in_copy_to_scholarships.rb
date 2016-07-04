class AddLoggedInCopyToScholarships < ActiveRecord::Migration
  def change
    add_column :scholarships, :logged_in_copy, :text
  end
end
