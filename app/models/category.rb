class Category < ActiveRecord::Base
  has_many :values, -> { order 'values.end_date' }, inverse_of: :category, dependent: :destroy
  has_many :topic_categories, inverse_of: :category, dependent: :destroy
  has_many :topics, through: :topic_categories

end
