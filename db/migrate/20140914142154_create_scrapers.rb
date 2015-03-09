class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.string :scope
      t.string :selector
      t.string :condition
      t.string :element
      t.string :attr
      t.string :source_pattern
      t.string :source_replacement
      t.string :url_prefix
      t.string :url_postfix
      t.boolean :active

      t.timestamps
    end
  end
end
