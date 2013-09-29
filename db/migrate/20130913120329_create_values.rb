class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.integer :category_id
      t.string :name
      t.string :old_price
      t.string :new_price
      t.string :discount
      t.string :url
      t.boolean :active
      t.date :end_date

      t.timestamps
    end

    add_index :values, [:category_id, :active, :end_date], :order => {end_date: :asc}
  end
end
