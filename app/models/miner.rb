class Miner < ActiveRecord::Base
  belongs_to :category
  has_many :miner_scrapers, inverse_of: :miner, dependent: :destroy
  has_many :scrapers, through: :miner_scrapers

  def perform
    source = self.miner_scrapers.map { |link|
      link.scraper.perform(link.url, link.limit)
    }.reduce(:merge)
    category.reconcile(source) if source
  end

end
