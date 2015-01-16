class MiningService

  def initialize(miner)
    @miner = miner
  end

  def perform
    @miner.miner_scrapers.map { |miner_scraper|
      service = ScrapingService.new(miner_scraper)
      service.perform
    }.flatten
  end

end