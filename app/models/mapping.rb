class Mapping < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  has_many :transformers, inverse_of: :mapping, dependent: :destroy
  delegate :texts, :attachments, :orders, :has_manies, to: :transformers
  after_create :reorder

  def reorder
    update_attribute(:order, (Mapping.where('mappings.source_id = ? AND mappings.source_type = ?',
                                            self.source.id, self.source_type).maximum(:order) || 0) + 1) unless self.order
  end

  def move_up
    upper = Mapping.where('mappings.source_id = ? AND mappings.source_type = ? AND mappings.order < ?',
                          self.source.id, self.source_type, self.order).order(order: :desc).limit(1).first
    switch_order(upper) if upper
  end

  def move_down
    lower = Mapping.where('mappings.source_id = ? AND mappings.source_type = ? AND mappings.order > ?',
                          self.source.id, self.source_type, self.order).order(order: :asc).limit(1).first
    switch_order(lower) if lower
  end

  def perform(doc, context)
    doc.css(self.scope).map { |part|
      transformers.map { |transformer|
        transformer.perform part, context
      }.reduce(:merge)
    }
  end

  private
  def switch_order(other)
    low = other.order
    other.update_attribute(:order, self.order)
    update_attribute(:order, low)
  end

end
