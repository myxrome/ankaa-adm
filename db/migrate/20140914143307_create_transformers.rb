class CreateTransformers < ActiveRecord::Migration
  def change
    create_table :transformers do |t|
      t.integer :mapping_id
      t.string :type
      t.string :name
      t.string :key
      t.string :element
      t.string :attr
      t.string :substring
      t.string :prefix
      t.string :postfix
      t.boolean :order
      t.boolean :source

      t.timestamps
    end
  end
end
