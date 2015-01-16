class Extractor < ActiveRecord::Base
  belongs_to :mapping, inverse_of: :extractors
  has_many :mappings, -> { order(:order) }, as: :source, dependent: :destroy

  scope :texts, -> { where(type: :text) }
  scope :attribute_values, -> { where(type: :attribute_value) }
  scope :attachments, -> { where(type: :attachment) }
  scope :has_manies, -> { where(type: :has_many) }

  def self.types
    [:Text, :AttributeValue, :Attachment, :HasMany]
  end

  def test(url)
    self.mapping.test(url) { |scope|
      wrap_test_value(get_value(scope).to_s)
    }
  end

  def perform(scope)
    {self.key.to_sym => get_value(scope)}
  end

  protected
  def get_value(scope)
  end

  def wrap_test_value(value)
    value
  end

end

class Text < Extractor
  protected
  def get_value(scope)
    node = self.element.empty? ? scope : scope.css(self.element)
    node = node.first if node.is_a?(Nokogiri::XML::NodeSet)
    if node
      source = node.inner_text.strip if node.inner_text
      if source
        pattern = (self.substring.nil? || self.substring.empty?) ? '.*' : self.substring
        self.prefix + source.scan(/#{pattern}/).first + self.postfix
      else
        raise "Empty inner text for #{self.element}"
      end
    else
      raise "Empty result for #{self.element}"
    end
  end

end

class AttributeValue < Extractor
  protected
  def get_value(scope)
    node = self.element.empty? ? scope : scope.css(self.element)
    node = node.first if node.is_a?(Nokogiri::XML::NodeSet)
    if node
      source = node[self.attr]
      if source
        pattern = (self.substring.nil? || self.substring.empty?) ? '.*' : self.substring
        self.prefix + source.scan(/#{pattern}/).first + self.postfix
      else
        raise "Empty result for attribute #{self.attr} in element #{self.element}"
      end
    else
      raise "Empty result for #{self.element}"
    end
  end
end

class Attachment < Extractor
  protected
  def get_value(scope)
    node = self.element.empty? ? scope : scope.css(self.element)
    node = node.first if node.is_a?(Nokogiri::XML::NodeSet)
    if node
      source = node[self.attr]
      if source
        pattern = (self.substring.nil? || self.substring.empty?) ? '.*' : self.substring
        url = self.prefix + source.scan(/#{pattern}/).first + self.postfix
        URI.parse(url)
      else
        raise "Empty result for attribute #{self.attr} in element #{self.element}"
      end
    else
      raise "Empty result for #{self.element}"
    end
  end

  def wrap_test_value(value)
    "<a target='_blank' href='#{value}'>#{value}</a>"
  end
end

class HasMany < Extractor
  protected
  def get_value(scope)
    order = 0
    mappings.map { |mapping|
      mapping.perform(scope) { |part, value|
        value = self.order? ? value.merge({order: (order += 1)}) : value
        self.source? ? value.merge({source: part.css_path}) : value
      }
    }.flatten
  end
end