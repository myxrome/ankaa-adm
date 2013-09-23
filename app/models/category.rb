class Category < ActiveRecord::Base
  has_many :values, -> {order 'values.end_date'}, inverse_of: :category
  has_many :application_categories, inverse_of: :category

end
