class ScrapeDataService

  def initialize(miner_scraper)
    @scraper = miner_scraper.scraper
  end

  def scrape_data_from_url(url)
    begin
      document = Nokogiri::HTML(open(url))

      @scraper.mappings.map { |mapping|

        service = MapDataService.new(mapping)
        service.map_data_from_document(document) { |part, value|
          value = @scraper.source? ? value.merge({source: url.strip}) : value

          !@scraper.url_prefix.empty? || !@scraper.url_postfix.empty? ?
              value.merge({url: @scraper.url_prefix + ERB::Util.url_encode(url.strip) + @scraper.url_postfix}) :
              value
        }

      }
    rescue Exception => e
      # miner.on_error "Extract data from page #{url} gets error: #{e.message}" if miner
      Array.new
    end
  end

end