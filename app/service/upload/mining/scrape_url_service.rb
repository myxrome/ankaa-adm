class ScrapeURLService
  require 'open-uri'

  def initialize(miner_scraper)
    @miner_scraper = miner_scraper
    @scraper = miner_scraper.scraper
  end

  def scrape_urls
    begin
      current_page = 0
      result = Set.new

      begin
        current_page += 1
        doc = get_document(current_page)
        portion = scrape_urls_from_document(doc)

        break if !portion.empty? && result > portion
        result.merge portion
      end while result.size < @miner_scraper.limit && current_page < MAX_PAGER

      result.to_a.take(@miner_scraper.limit)
    rescue Exception => e
      UploadErrorReportingService.instance.on_error(e)
      Array.new
    end
  end

  def scrape_urls_from_document(document)
    begin
      scope = @scraper.scope.empty? ? 'body' : @scraper.scope

      result = document.css(scope).map { |s|
        s.css(@scraper.selector).reject { |e|
          not @scraper.condition.empty? and e.css(@scraper.condition).empty?
        }.map { |e|
          scrape_url_from_item(e)
        }
      }.flatten

      Set.new result
    rescue Exception => e
      UploadErrorReportingService.instance.on_error(e)
      Set.new
    end
  end

  private
  MAX_PAGER = 20

  def get_document(current_page)
    url = @miner_scraper.url_prefix + current_page.to_s +
        @miner_scraper.url_postfix
    Nokogiri::HTML(open(url))
  end

  def scrape_url_from_item(item)
    begin
      target = @scraper.element.empty? ? item : item.css(@scraper.element)
      target = target.first if target.is_a?(Nokogiri::XML::NodeSet)
      if target
        if target[@scraper.attr]
          @scraper.source_prefix + target[@scraper.attr] + @scraper.source_postfix
        else
          raise "Element #{@scraper.element} doesn't contain attribute #{@scraper.attr}"
        end
      else
        raise "Page doesn't contain #{@scraper.element} with condition #{@scraper.condition}"
      end
    rescue Exception => e
      UploadErrorReportingService.instance.on_error(e)
      ''
    end
  end

end