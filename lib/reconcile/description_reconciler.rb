module DescriptionReconciler
  include Reconciler

  def reconcile(params, callback_context)
    assign_attributes(params)
    self
  end

end