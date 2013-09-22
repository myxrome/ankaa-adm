class DescriptionTemplate < ActiveRecord::Base
  has_many :descriptions

  def self.select_captions_like(pattern)
    select([:caption]).where('lower(caption) LIKE lower(?)', "%#{pattern}%")
  end

end
