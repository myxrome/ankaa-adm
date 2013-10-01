class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.integer :value_id
      t.attachment :image
      t.integer :order

      t.timestamps
    end
  end
end
