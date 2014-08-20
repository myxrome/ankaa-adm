class CreateVirtualContexts < ActiveRecord::Migration
  def change
    create_table :virtual_contexts do |t|
      t.string :name
      t.string :description
      t.integer :virtual_context_type_id

      t.timestamps
    end

    add_index :virtual_contexts, :virtual_context_type_id
  end
end
