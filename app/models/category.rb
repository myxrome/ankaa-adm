class Category < ActiveRecord::Base
  has_many :value_categories
  has_many :values, through: :value_categories

end
