class Scraper < ActiveRecord::Base
  require 'open-uri'

  has_many :miner_scrapers, inverse_of: :scraper, dependent: :destroy
  has_many :mappings, -> { order(:order) }, as: :source

  def perform(miner, miner_scraper)
    source_urls = collect_source_urls(miner, miner_scraper)
    source_urls.map { |url|
      pattern = (self.substring.nil? || self.substring.empty?) ? '.*' : self.substring
      extract_data(miner, url.scan(/#{pattern}/).first)
    }.flatten
  end

  def test(url)
    return if !url || url.empty?
    doc = Nokogiri::HTML(open(url))
    extract_source_urls(nil, url, doc).first(5).map { |r|
      pattern = (self.substring.nil? || self.substring.empty?) ? '.*' : self.substring
      wrap_test_result(r.scan(/#{pattern}/).first)
    } if doc
  end

  private
  MAX_PAGER = 20

  def collect_source_urls(miner, miner_scraper)
    begin
      current_page = 0
      result = Set.new
      begin
        current_page += 1
        url = miner_scraper.url_prefix + current_page.to_s +
            miner_scraper.url_postfix
        doc = Nokogiri::HTML(open(url))

        portion = extract_source_urls(miner, url, doc)

        break if !portion.empty? && result > portion
        result.merge portion
      end while result.size < miner_scraper.limit && current_page < MAX_PAGER
      result.to_a.take(miner_scraper.limit)
    rescue Exception => e
      miner.on_error e.message if miner
      Array.new
    end
  end

  def extract_source_urls(miner, url, doc)
    begin
      Set.new doc.css(self.scope.empty? ? 'body' : self.scope).map { |s|
        s.css(self.selector).reject { |e|
          not self.condition.empty? and e.css(self.condition).empty?
        }.map { |e|
            extract_source_url(miner, url, e)
        }
      }.flatten
    rescue Exception => e
      miner.on_error e.message if miner
      Set.new
    end
  end

  def extract_source_url(miner, url, item)
    begin
      target = self.element.empty? ? item : item.css(self.element)
      target = target.first if target.is_a?(Nokogiri::XML::NodeSet)
      if target
        if target[self.attr]
          self.prefix + target[self.attr] + self.postfix
        else
          raise "Element #{self.element} doesn't contain attribute #{self.attr} on page #{url}"
        end
      else
        raise "Page #{url} doesn't contain #{self.element} with condition #{self.condition}"
      end
    rescue Exception => e
      miner.on_error e.message if miner
      ''
    end
  end

  def extract_data(miner, url)
    begin
      doc = Nokogiri::HTML(open(url))
      self.mappings.map { |mapping|
        mapping.perform(doc) { |part, value|
          self.source? ? value.merge({source: url.strip}) : value
        }
      }
    rescue Exception => e
      miner.on_error "Extract data from page #{url} gets error: #{e.message}" if miner
      Array.new
    end
  end

  def wrap_test_result(result)
    "<a target='_blank' href='#{result}'>#{result}</a>"
  end

end
