class Transformer < ActiveRecord::Base
  belongs_to :mapping, inverse_of: :transformers
  has_many :mappings, -> { order(:order) }, as: :source, dependent: :destroy

  scope :texts, -> { where(type: :text) }
  scope :attachments, -> { where(type: :attachment) }
  scope :orders, -> { where(type: :order) }
  scope :has_manies, -> { where(type: :has_many) }

  def self.types
    [:Text, :Attachment, :Order, :HasMany]
  end

  def perform(scope, context)
    {self.key.to_sym => get_value(scope, context)}
  end

  protected
  def get_value(scope, context)
  end

end

class Text < Transformer
  protected
  def get_value(scope, context)
    scope.css(self.element).inner_text.strip
  end
end

class Attachment < Transformer
  protected
  def get_value(scope, context)
    node = self.element.empty? ? scope : scope.css(self.element)
    url = self.prefix + node[self.attr] + self.postfix
    URI.parse(url)
  end
end

class Order < Transformer
  protected
  def get_value(scope, context)
    context[:order] ||= 0
    context[:order] += 1
  end
end

class HasMany < Transformer
  protected
  def get_value(scope, c)
    context = Hash.new
    mappings.map { |mapping|
      mapping.perform(scope, context).map { |value|
        {rand(10000).to_s.to_sym => value}
      }.reduce(:merge)
    }.reduce(:merge)
  end
end