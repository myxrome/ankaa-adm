class CreateTransformers < ActiveRecord::Migration
  def change
    create_table :transformers do |t|
      t.integer :mapping_id
      t.string :type
      t.string :name
      t.string :key
      t.string :order_key
      t.string :element
      t.string :attr
      t.string :prefix
      t.string :postfix

      t.timestamps
    end
  end
end
