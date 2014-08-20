class VirtualContext < ActiveRecord::Base
  belongs_to :virtual_context_type, inverse_of: :virtual_contexts
  has_many :facts, as: :context

end
