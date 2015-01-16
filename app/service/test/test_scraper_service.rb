class TestScraperService
  require 'open-uri'

  def initialize(scraper)
    @scraper = scraper
  end

  def perform(url)
    return if !url || url.empty?
    doc = Nokogiri::HTML(open(url))
    scrape_urls_from_document(nil, url, doc).first(5).map { |r|
      pattern = (@scraper.substring.nil? || @scraper.substring.empty?) ? '.*' : @scraper.substring
      wrap_test_result(r.scan(/#{pattern}/).first)
    } if doc
  end

  private

  def wrap_test_result(result)
    "<a target='_blank' href='#{result}'>#{result}</a>"
  end

end