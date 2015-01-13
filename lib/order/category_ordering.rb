module CategoryOrdering
  extend ActiveSupport::Concern

  included do
    scope :neighbors, -> (category) { where(topic_id: category.topic_id) }
  end

end