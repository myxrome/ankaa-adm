class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.string :selector
      t.string :condition
      t.string :prefix
      t.string :postfix
      t.string :paginator

      t.timestamps
    end
  end
end
