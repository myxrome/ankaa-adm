class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.string :name
      t.string :old_price
      t.string :new_price
      t.float :discount
      t.datetime :end_date
      t.string :url

      t.timestamps
    end
  end
end
