class Mapping < ActiveRecord::Base
  include Order

  scope :neighbors, -> (mapping) { where(source_id: mapping.source_id, source_type: mapping.source_type) }

  def neighbors
    Mapping.neighbors(self)
  end

  belongs_to :source, polymorphic: true
  has_many :transformers, inverse_of: :mapping, dependent: :destroy
  delegate :texts, :attribute_values, :attachments, :has_manies, to: :transformers

  def test(url)
    return if !url || url.empty?
    doc = Nokogiri::HTML(open(url))
    doc.css(self.scope).map { |part|
      yield(part)
    }.first(5)
  end

  def perform(doc)
    doc.css(self.scope).map { |part|
      result = perform_transformers(part)
      block_given? ? yield(part, result) : result
    }
  end

  private
  def perform_transformers(part)
    transformers.map { |transformer|
      transformer.perform(part)
    }.reduce(:merge)
  end

end
