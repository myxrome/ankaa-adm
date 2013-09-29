class Value < ActiveRecord::Base
  belongs_to :category, inverse_of: :values
  has_many :descriptions, -> { order 'descriptions.order' }, inverse_of: :value
  accepts_nested_attributes_for :descriptions, :reject_if => :all_blank, :allow_destroy => true

end
