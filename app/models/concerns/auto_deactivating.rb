module AutoDeactivating
  extend ActiveSupport::Concern

  included do
    after_save :deactivate
  end

  def deactivate
    unless self.active?
      service = DeactivateServiceFactory.instance.build_deactivate_service self
      service.perform
    end
  end

end