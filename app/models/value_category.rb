class ValueCategory < ActiveRecord::Base
  belongs_to :value, touch: true
  belongs_to :category

end
