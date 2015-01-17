class ScrapingService

  def initialize(miner_scraper)
    @miner_scraper = miner_scraper
    @scraper = miner_scraper.scraper
  end

  def perform
    service = ScrapeDataService.new(@miner_scraper)
    pattern = @scraper.substring.blank? ? '.*' : @scraper.substring

    scrape_urls.map { |url|
      service.scrape_data_from_url(url.scan(/#{pattern}/).first)
    }.flatten
  end

  def scrape_urls
    serivce = ScrapeURLService.new(@miner_scraper)
    serivce.scrape_urls
  end

end