class Miner < ActiveRecord::Base
  belongs_to :category
  has_many :miner_scrapers, inverse_of: :miner, dependent: :destroy
  has_many :scrapers, through: :miner_scrapers

  def perform
    self.miner_scrapers.each { |link|
      link.scraper.perform link.url, link.limit
    }
  end

end
