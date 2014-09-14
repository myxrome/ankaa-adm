class CreateMiners < ActiveRecord::Migration
  def change
    create_table :miners do |t|
      t.string :name
      t.integer :category_id

      t.timestamps
    end
  end
end
