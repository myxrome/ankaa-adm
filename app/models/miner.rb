class Miner < ActiveRecord::Base
  belongs_to :category
  has_many :miner_scraper_relations, inverse_of: :miner, dependent: :destroy
  has_many :scrapers, through: :miner_scraper_relations
end
