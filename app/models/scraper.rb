class Scraper < ActiveRecord::Base
  has_many :miner_scrapers, inverse_of: :scraper, dependent: :destroy
  has_many :partitions, -> { order(:order) }, as: :source, dependent: :destroy

end
