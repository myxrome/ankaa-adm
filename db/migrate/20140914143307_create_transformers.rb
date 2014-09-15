class CreateTransformers < ActiveRecord::Migration
  def change
    create_table :transformers do |t|
      t.integer :mapping_id
      t.string :type
      t.string :key
      t.string :selector
      t.string :prefix
      t.string :postfix

      t.timestamps
    end
  end
end
