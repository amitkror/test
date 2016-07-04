class CreateResourcePhases < ActiveRecord::Migration
  def change
    create_table :resource_phases do |t|
      t.references :resource, null: false
      t.references :phase, null: false

      t.timestamps
    end
    add_index :resource_phases, :resource_id
    add_index :resource_phases, :phase_id
  end
end
