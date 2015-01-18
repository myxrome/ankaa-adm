module AutoOrdering
  extend ActiveSupport::Concern

  included do
    before_create :init_order
  end

  def init_order
    unless self.order
      service = OrderingService.new(self)
      self.order = service.next_order
    end
  end

end