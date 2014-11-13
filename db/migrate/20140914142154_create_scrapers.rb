class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.string :scope
      t.string :selector
      t.string :condition
      t.string :element
      t.string :attr
      t.string :substring
      t.string :source_prefix
      t.string :source_postfix
      t.boolean :source
      t.string :url_prefix
      t.string :url_postfix

      t.timestamps
    end
  end
end
