class CreateDescriptionTemplates < ActiveRecord::Migration
  def change
    create_table :description_templates do |t|
      t.string :caption

      t.timestamps
    end
  end
end
