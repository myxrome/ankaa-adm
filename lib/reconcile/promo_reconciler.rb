module PromoReconciler
  include Reconciler

  def reconcile(params, callback_context)
    assign_attributes(image.exists? ? params.except(:image) : params)
    self
  end

end