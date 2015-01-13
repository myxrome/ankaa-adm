module TopicOrdering
  extend ActiveSupport::Concern

  included do
    scope :neighbors, -> (topic) { where(topic_group_id: topic.topic_group_id) }
  end

end