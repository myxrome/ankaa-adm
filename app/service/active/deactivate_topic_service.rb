class DeactivateTopicService

  def initialize(topic)
    @topic = topic
  end

  def perform
    @topic.categories.update_all active: false
    @topic.categories.find_each { |category|
      service = DeactivateCategoryService.new category
      service.perform
    }
  end

end