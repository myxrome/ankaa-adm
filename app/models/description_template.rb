class DescriptionTemplate < ActiveRecord::Base
  has_many :descriptions, inverse_of: :description_template

  def self.select_captions_like(pattern)
    select([:caption]).where('lower(caption) LIKE lower(?)', "%#{pattern}%")
  end

end
