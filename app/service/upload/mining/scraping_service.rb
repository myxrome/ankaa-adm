class ScrapingService

  def initialize(miner_scraper)
    @miner_scraper = miner_scraper
    @scraper = miner_scraper.scraper
  end

  def perform
    service = ScrapeDataService.new(@miner_scraper)

    scrape_urls.map { |url|
      service.scrape_data_from_url(url)
    }.flatten
  end

  def scrape_urls
    serivce = ScrapeURLService.new(@miner_scraper.scraper)
    serivce.scrape_urls(@miner_scraper)
  end

end