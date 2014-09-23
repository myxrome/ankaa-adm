class Transformer < ActiveRecord::Base
  belongs_to :mapping, inverse_of: :transformers
  has_many :mappings, -> { order(:order) }, as: :source, dependent: :destroy

  scope :texts, -> { where(type: :text) }
  scope :attachments, -> { where(type: :attachment) }
  scope :has_manies, -> { where(type: :has_many) }

  def self.types
    [:Text, :Attachment, :HasMany]
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
    scope.css(self.element).inner_text.strip
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
      mapping.perform(scope).map { |value|
        value.merge!({self.order_key.to_sym => (order += 1)}) unless self.order_key.empty?
        {rand(10000).to_s.to_sym => value}
      }.reduce(:merge)
    }.reduce(:merge)
  end
end