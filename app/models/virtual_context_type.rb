class VirtualContextType < ActiveRecord::Base
  has_many :virtual_contexts, inverse_of: :virtual_context_type
end
