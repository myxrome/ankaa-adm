class Value < ActiveRecord::Base
  has_one :category
  has_many :descriptions
  accepts_nested_attributes_for :descriptions, :reject_if => :all_blank, :allow_destroy => true

end
