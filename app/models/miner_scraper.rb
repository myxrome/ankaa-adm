class MinerScraper < ActiveRecord::Base
belongs_to :miner
  belongs_to :scraper
end
