class TestingScraperService
  require 'open-uri'

  def initialize(scraper)
    @scraper = scraper
  end

  def perform(url)
    return if url.blank?
    doc = Nokogiri::HTML(open(url))
    if doc
      service = ScrapeURLService.new(@scraper)
      service.scrape_urls_from_document(doc).first(5).map { |r|
        wrap_test_result(r)
      }
    end
  end

  private

  def wrap_test_result(result)
    "<a target='_blank' href='#{result}'>#{result}</a>"
  end

end