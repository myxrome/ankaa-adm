module TopicGroupOrdering
  extend ActiveSupport::Concern

  included do
    scope :neighbors, -> (topic_group) { all }
  end

end