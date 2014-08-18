class CreateVirtualContextTypes < ActiveRecord::Migration
  def change
    create_table :virtual_context_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
