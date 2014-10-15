class Scraper < ActiveRecord::Base
  require 'open-uri'

  has_many :miner_scrapers, inverse_of: :scraper, dependent: :destroy
  has_many :mappings, -> { order(:order) }, as: :source

  def perform(url_prefix, url_postfix, limit)
    links = collect_links(url_prefix, url_postfix, limit)
    links.map { |link|
      extract_data(link)
    }.flatten
  end

  def test(url)
    return if !url || url.empty?
    doc = Nokogiri::HTML(open(url))
    extract_links(doc).first(5).map { |r|
      "<a target='_blank' href='#{r}'>#{r}</a>"
    } if doc
  end

  private
  MAX_PAGER = 20

  def collect_links(url_prefix, url_postfix, limit)
    current_page = 0
    links = Set.new
    begin
      doc = Nokogiri::HTML(open(url_prefix + (current_page += 1).to_s + url_postfix))
      break unless doc

      extracted = extract_links(doc)

      break if !extracted.empty? && links > extracted
      links.merge extracted
    end while links.size < limit && current_page < MAX_PAGER
    links.to_a.take(limit)
  end

  def extract_links(doc)
    Set.new doc.css(self.scope.empty? ? 'body' : self.scope).map { |scp|
      scp.css(self.selector).reject { |e|
        not self.condition.empty? and e.css(self.condition).empty?
      }.map { |e|
        target = self.element.empty? ? e : e.css(self.element)
        target = target.first if target.is_a?(Nokogiri::XML::NodeSet)
        self.prefix + target[self.attr] + self.postfix
      }
    }.flatten
  end

  def extract_data(link)
    doc = Nokogiri::HTML(open(link))
    self.mappings.map { |mapping|
      perform_mapping(mapping, link, doc)
    }
  end

  def perform_mapping(mapping, link, doc)
    mapping.perform(doc) { |part, value|
      self.source? ? value : value.merge({source: link})
    }
  end

end
