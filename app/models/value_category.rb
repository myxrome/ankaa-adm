class ValueCategory < ActiveRecord::Base
  belongs_to :value
  belongs_to :category

end
