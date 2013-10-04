class Description < ActiveRecord::Base
  belongs_to :description_template, inverse_of: :descriptions
  belongs_to :value, touch: true, inverse_of: :descriptions

  def caption
    self.description_template.caption if self.description_template
  end

  def caption=(value)
    self.description_template = DescriptionTemplate.find_or_create_by caption: value
  end

end
