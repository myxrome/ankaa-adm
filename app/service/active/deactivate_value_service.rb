class DeactivateValueService

  def initialize(value)
    @value = value
  end

  def perform
    @value.descriptions.update_all active: false
    @value.promos.update_all active: false
  end

end