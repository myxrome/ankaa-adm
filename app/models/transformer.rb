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

  def perform(scope)
    {self.key.to_sym => get_value(scope)}
  end

  protected
  def get_value(scope)
  end

end

class Text < Transformer
  protected
  def get_value(scope)
    node = self.element.empty? ? scope : scope.css(self.element)
    node.inner_text.strip
  end
end

class AttributeValue < Transformer
  protected
  def get_value(scope)
    node = self.element.empty? ? scope : scope.css(self.element)
    self.prefix + node[self.attr] + self.postfix
  end
end

class Attachment < Transformer
  protected
  def get_value(scope)
    node = self.element.empty? ? scope : scope.css(self.element)
    url = self.prefix + node[self.attr] + self.postfix
    URI.parse(url)
  end
end

class HasMany < Transformer
  protected
  def get_value(scope)
    order = 0
    mappings.map { |mapping|
      result = mapping.perform(scope) { |part, value|
        value = self.order_key.empty? ? value : value.merge({self.order_key.to_sym => (order += 1)})
        self.source_key.empty? ? value : value.merge({self.source_key.to_sym => part.css_path})
      }
      {result[:source] || rand(10000).to_s => result}
    }.reduce(:merge)
  end
end