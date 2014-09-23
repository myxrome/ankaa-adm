class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.string :element
      t.string :attr
      t.string :condition
      t.string :prefix
      t.string :postfix
      t.string :paginator
      t.string :source_key

      t.timestamps
    end
  end
end
