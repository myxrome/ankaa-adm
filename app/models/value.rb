class Value < ActiveRecord::Base
  belongs_to :category, inverse_of: :values
  has_many :descriptions, -> { order 'descriptions.order' }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :descriptions, reject_if: :all_blank, allow_destroy: true
  has_many :promos, -> { order 'promos.order' }, inverse_of: :value, dependent: :destroy
  accepts_nested_attributes_for :promos, reject_if: :all_blank, allow_destroy: true

  def thumb
    promos.first.image.url(:thumb)
  end

end
