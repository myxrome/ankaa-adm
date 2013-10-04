class Category < ActiveRecord::Base
  has_many :values, -> { order 'values.end_date' }, inverse_of: :category, dependent: :destroy
  has_many :application_categories, inverse_of: :category, dependent: :destroy
  has_many :applications, through: :application_categories

end
