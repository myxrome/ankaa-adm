class Description < ActiveRecord::Base
  has_one :description_template
  belongs_to :value, touch: true

end
