class Transformer < ActiveRecord::Base
  belongs_to :mapping, inverse_of: :transformers
  has_many :mappings, as: :source, dependent: :destroy

  scope :texts, -> { where(type: :text) }
  scope :attachments, -> { where(type: :attachment) }
  scope :orders, -> { where(type: :order) }
  scope :has_manies, -> { where(type: :has_many) }

  def self.types
    [:Text, :Attachment, :Order, :HasMany]
  end

end

class Text < Transformer
end

class Attachment < Transformer
end

class Order < Transformer
end

class HasMany < Transformer
end