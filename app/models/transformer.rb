class Transformer < ActiveRecord::Base
  belongs_to :mapping, inverse_of: :transformers
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
      wrap(get_value(scope).to_s)
    }
  end

  def perform(scope)
    {self.key.to_sym => get_value(scope)}
  end

  protected
  def get_value(scope)
  end

  def wrap(value)
    value
  end

end

class Text < Transformer
  # TODO: replace (scan)
  protected
  def get_value(scope)
    extract_value(scope)
  end

  def extract_value(scope)
    node = self.element.empty? ? scope : scope.css(self.element)
    node = node.first if node.is_a?(Nokogiri::XML::NodeSet)
    pattern = (self.substring.nil? || self.substring.empty?) ? '.*' : self.substring
    self.prefix + node.inner_text.strip.scan(/#{pattern}/).first + self.postfix
  end
end

class AttributeValue < Transformer
  protected
  def get_value(scope)
    node = self.element.empty? ? scope : scope.css(self.element)
    node = node.first if node.is_a?(Nokogiri::XML::NodeSet)
    pattern = (self.substring.nil? || self.substring.empty?) ? '.*' : self.substring
    self.prefix + node[self.attr].scan(/#{pattern}/).first + self.postfix
  end
end

class Attachment < Transformer
  protected
  def get_value(scope)
    node = self.element.empty? ? scope : scope.css(self.element)
    node = node.first if node.is_a?(Nokogiri::XML::NodeSet)
    pattern = (self.substring.nil? || self.substring.empty?) ? '.*' : self.substring
    url = self.prefix + node[self.attr].scan(/#{pattern}/).first + self.postfix
    URI.parse(url)
  end

  def wrap(value)
    "<a target='_blank' href='#{value}'>#{value}</a>"
  end
end

class HasMany < Transformer
  protected
  def get_value(scope)
    order = 0
    mappings.map { |mapping|
      mapping.perform(scope) { |part, value|
        value = self.order? ? value : value.merge({order: (order += 1)})
        self.source? ? value : value.merge({source: part.css_path})
      }
    }.flatten
  end
end