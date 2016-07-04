class ChangeResourceWhenToText < ActiveRecord::Migration
  def up
    change_column(:resources, :when_text, :text)
  end

  def down
    change_column(:resources, :when_text, :string)
  end
end
