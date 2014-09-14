class CreateMinerScrapers < ActiveRecord::Migration
  def change
    create_table :miner_scrapers do |t|
      t.integer :miner_id
      t.integer :scraper_id
      t.string :url
      t.integer :limit

      t.timestamps
    end
  end
end
