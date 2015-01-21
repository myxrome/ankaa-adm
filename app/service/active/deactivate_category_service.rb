class DeactivateCategoryService

  def initialize(category)
    @category = category
  end

  def perform
    @category.values.update_all active: false
    @category.values.find_each { |value|
      service = DeactivateValueService.new value
      service.perform
    }
  end

end