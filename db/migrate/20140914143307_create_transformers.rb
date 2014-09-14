class CreateTransformers < ActiveRecord::Migration
  def change
    create_table :transformers do |t|
      t.string :type
      t.string :key
      t.string :selector
      t.string :attribute
      t.string :prefix
      t.string :postfix

      t.timestamps
    end
  end
end
