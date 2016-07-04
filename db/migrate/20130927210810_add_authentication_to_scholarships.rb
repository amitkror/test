class AddAuthenticationToScholarships < ActiveRecord::Migration
  def change
    add_column :scholarships, :require_authentication, :boolean, default: false
  end
end
