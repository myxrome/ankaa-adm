class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.integer :template_id
      t.integer :value_id
      t.integer :order
      t.text :text
      t.boolean :red
      t.boolean :bold

      t.timestamps
    end
  end
end
