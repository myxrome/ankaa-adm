class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.string :scope
      t.string :selector
      t.string :condition
      t.string :element
      t.string :attr
      t.string :prefix
      t.string :postfix
      t.boolean :source

      t.timestamps
    end
  end
end
