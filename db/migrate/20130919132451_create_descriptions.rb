class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.integer :description_template_id
      t.integer :value_id
      t.integer :order
      t.text :text
      t.boolean :red
      t.boolean :bold

      t.timestamps
    end

    add_index :descriptions, [:value_id, :order]
  end
end
