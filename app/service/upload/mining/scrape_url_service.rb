class ScrapeURLService
  require 'open-uri'

  def initialize(scraper)
    @scraper = scraper
    @current_url = ''
  end

  def scrape_urls(miner_scraper)
    begin
      current_page = 0
      result = Set.new

      begin
        current_page += 1
        doc = get_document(current_page, miner_scraper)
        portion = scrape_urls_from_document(doc)

        break if !portion.empty? && result > portion
        result.merge portion
      end while result.size < miner_scraper.limit && current_page < MAX_PAGER

      result.to_a.take(miner_scraper.limit)
    rescue => e
      n = e.exception "URL: #{@current_url} with error: #{e.message}"
      n.set_backtrace e.backtrace
      UploadErrorReportingService.instance.on_error(n)
      Array.new
    end
  end

  def scrape_urls_from_document(document)
    begin
      scope = @scraper.scope.blank? ? 'body' : @scraper.scope
      result = document.css(scope).map { |s|
        s.css(@scraper.selector).reject { |e|
          not @scraper.condition.blank? and e.css(@scraper.condition).empty?
        }.map { |e|
          scrape_url_from_item(e)
        }
      }.flatten

      Set.new result
    rescue => e
      n = e.exception "URL: #{@current_url} with error: #{e.message}"
      n.set_backtrace e.backtrace
      UploadErrorReportingService.instance.on_error(n)
      Set.new
    end
  end

  private
  MAX_PAGER = 20

  def get_document(current_page, miner_scraper)
    @current_url = miner_scraper.url_prefix + current_page.to_s +
        miner_scraper.url_postfix
    Nokogiri::HTML(open(@current_url))
  end

  def scrape_url_from_item(item)
    begin
      target = @scraper.element.blank? ? item : item.css(@scraper.element)
      target = target.first if target.is_a?(Nokogiri::XML::NodeSet)
      if target
        if target[@scraper.attr]
          target[@scraper.attr].gsub(/#{@scraper.source_pattern}/, @scraper.source_replacement)
        else
          raise "Element #{@scraper.element} doesn't contain attribute #{@scraper.attr}"
        end
      else
        raise "Page doesn't contain #{@scraper.element} with condition #{@scraper.condition}"
      end
    rescue => e
      n = e.exception "URL: #{@current_url} with error: #{e.message}"
      n.set_backtrace e.backtrace
      UploadErrorReportingService.instance.on_error(n)
      ''
    end
  end

end