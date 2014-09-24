class Scraper < ActiveRecord::Base
  require 'open-uri'

  has_many :miner_scrapers, inverse_of: :scraper, dependent: :destroy
  has_many :mappings, -> { order(:order) }, as: :source

  def perform(url, limit)
    links = collect_value_links(url, limit)
    links.map { |link|

      doc = Nokogiri::HTML(open(link))

      self.mappings.map { |mapping|
        result = mapping.perform(doc) { |part, value|
          self.source_key.empty? ? value : value.merge({self.source_key.to_sym => link})
        }
        {result[:source] => result}
      }.reduce(:merge)
    }.reduce(:merge)
  end

  private
  def collect_value_links(url, limit)
    current_page = 0
    links = Set.new
    begin
      doc = Nokogiri::HTML(open(url + self.paginator + (current_page += 1).to_s))
      break unless doc

      page = Set.new doc.css(self.element).reject { |e|
        not self.condition.empty? and e.css(self.condition).empty?
      }.map { |e|
        self.prefix + e[self.attr] + self.postfix
      }

      break if links > page
      links.merge page
    end while links.size < limit
    links.to_a.take(limit)
  end

end
