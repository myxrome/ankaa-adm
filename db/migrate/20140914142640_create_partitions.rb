class CreatePartitions < ActiveRecord::Migration
  def change
    create_table :partitions do |t|
      t.string :name
      t.string :scope
      t.integer :source_id
      t.string :source_type
      t.integer :order

      t.timestamps
    end

    add_index :partitions, [:source_id, :source_type]
  end
end
