class ScrapeDataService

  def initialize(miner_scraper)
    @scraper = miner_scraper.scraper
  end

  def scrape_data_from_url(url)
    begin
      document = Nokogiri::HTML(open(url))

      @scraper.partitions.map { |partition|

        service = ExtractPartitionService.new(partition)
        service.extract_partition_from_document(document) { |part, value|
          value = @scraper.source? ? value.merge({source: url.strip}) : value

          !@scraper.url_prefix.empty? || !@scraper.url_postfix.empty? ?
              value.merge({url: @scraper.url_prefix + ERB::Util.url_encode(url.strip) + @scraper.url_postfix}) :
              value
        }

      }
    rescue Exception => e
      ReportingService.instance.on_error(e)
      Array.new
    end
  end

end