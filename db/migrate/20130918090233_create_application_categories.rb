class CreateApplicationCategories < ActiveRecord::Migration
  def change
    create_table :application_categories do |t|
      t.integer :application_id
      t.integer :category_id

      t.timestamps
    end

    add_index :application_categories, :application_id
    add_index :application_categories, :category_id
  end
end
