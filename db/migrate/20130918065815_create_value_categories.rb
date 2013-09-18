class CreateValueCategories < ActiveRecord::Migration
  def change
    create_table :value_categories do |t|
      t.integer :value_id
      t.integer :category_id

      t.timestamps
    end
  end
end
