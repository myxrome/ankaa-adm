class Description < ActiveRecord::Base
  has_one :description_template, foreign_key: "template_id", inverse_of: :descriptions
  belongs_to :value, touch: true, autosave: true, inverse_of: :descriptions

end
