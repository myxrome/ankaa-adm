class Value < ActiveRecord::Base
  has_many :value_categories
  has_many :categories, through: :value_categories

end
