class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.string :key

      t.timestamps
    end

    add_index :applications, :key, :unique => true
  end
end
