class Partition < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  has_many :extractors, inverse_of: :partition, dependent: :destroy
  delegate :texts, :attribute_values, :attachments, :has_manies, to: :extractors

  scope :neighbors, -> (partition) { where(source_id: partition.source_id, source_type: partition.source_type) }

end
