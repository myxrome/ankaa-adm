class Transformer < ActiveRecord::Base
  has_many :mappings, as: source

end

class Text < Transformer
end

class Attachment < Transformer
end

class Order < Transformer
end

class HasMany < Transformer
end