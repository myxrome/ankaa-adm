class Mapping < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  has_many :extractors, inverse_of: :mapping, dependent: :destroy
  delegate :texts, :attribute_values, :attachments, :has_manies, to: :extractors

  scope :neighbors, -> (mapping) { where(source_id: mapping.source_id, source_type: mapping.source_type) }

end
