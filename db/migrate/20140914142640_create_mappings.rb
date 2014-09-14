class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.string :scope
      t.integer :source_id
      t.string :source_type

      t.timestamps
    end

    add_index :mappings, [:source_id, :source_type]
  end
end
