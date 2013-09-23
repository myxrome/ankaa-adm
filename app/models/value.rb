class Value < ActiveRecord::Base
  has_one :category, inverse_of: :values
  has_many :descriptions, inverse_of: :value
  accepts_nested_attributes_for :descriptions, :reject_if => :all_blank, :allow_destroy => true

end
