class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :key

      t.timestamps
    end

    add_index :topics, :key, :unique => true
  end
end
