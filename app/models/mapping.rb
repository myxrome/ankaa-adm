class Mapping < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  has_many :transformers, inverse_of: :mapping, dependent: :destroy
  delegate :texts, :attachments, :orders, :has_manies, to: :transformers

end
