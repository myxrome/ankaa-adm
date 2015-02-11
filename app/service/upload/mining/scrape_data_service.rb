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
          value = value.merge({source: url.strip})

          !@scraper.url_prefix.blank? || !@scraper.url_postfix.blank? ?
              value.merge({url: @scraper.url_prefix + ERB::Util.url_encode(url.strip) + @scraper.url_postfix}) :
              value
        }

      }
    rescue => e
      n = e.exception "URL: #{url} with error: #{e.message}"
      n.set_backtrace e.backtrace
      UploadErrorReportingService.instance.on_error(n)
      Array.new
    end
  end

end