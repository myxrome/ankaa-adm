class CreateExtractors < ActiveRecord::Migration
  def change
    create_table :extractors do |t|
      t.integer :partition_id
      t.string :type
      t.string :name
      t.string :key
      t.string :element
      t.string :attr
      t.string :pattern
      t.string :replacement
      t.boolean :order
      t.boolean :source
      t.boolean :required

      t.timestamps
    end
  end
end
