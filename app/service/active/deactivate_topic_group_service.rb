class DeactivateTopicGroupService

  def initialize(topic_group)
    @topic_group = topic_group
  end

  def perform
    @topic_group.topics.update_all active: false
    @topic_group.topics.find_each { |topic|
      service = DeactivateTopicService.new topic
      service.perform
    }
  end

end