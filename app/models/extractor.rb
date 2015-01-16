class Extractor < ActiveRecord::Base
  belongs_to :partition, inverse_of: :extractors
  has_many :partitions, -> { order(:order) }, as: :source, dependent: :destroy

  scope :texts, -> { where(type: :text) }
  scope :attribute_values, -> { where(type: :attribute_value) }
  scope :attachments, -> { where(type: :attachment) }
  scope :has_manies, -> { where(type: :has_many) }

  def self.types
    [:Text, :AttributeValue, :Attachment, :HasMany]
  end

end

class Text < Extractor
end

class AttributeValue < Extractor
end

class Attachment < Extractor
end

class HasMany < Extractor
end