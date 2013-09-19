class Category < ActiveRecord::Base
  has_many :values, -> {order 'values.end_date'}
  has_many :application_categories
  has_many :applications, through: :application_categories

end
