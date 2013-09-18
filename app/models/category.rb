class Category < ActiveRecord::Base
  has_many :value_categories
  has_many :values, through: :value_categories
  has_many :application_categories
  has_many :applications, through: :application_categories

end
