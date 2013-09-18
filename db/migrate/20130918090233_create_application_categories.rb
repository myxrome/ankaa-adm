class CreateApplicationCategories < ActiveRecord::Migration
  def change
    create_table :application_categories do |t|
      t.integer :application_id
      t.integer :category_id

      t.timestamps
    end
  end
end
