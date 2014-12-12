module CategoryReconciler
  include Reconciler

  def reconcile(params, callback_context)
    reconcile_associations(params, callback_context)
  end

  def reconcile_associations(params, callback_context)
    reconcile_association(self.values, params, callback_context)
  end

  def on_create(child, callback_context)
    callback_context.on_new child
  end

  def on_update(child, callback_context)
    callback_context.on_update child
  end

  def on_delete(child, callback_context)
    callback_context.on_delete child
  end

  def on_error(e, callback_context)
    callback_context.on_error "#{e.backtrace.first}: #{e.message} (#{e.class}) cause: #{e.cause}"
  end

  protected
  def delete(child)
    child.update_attribute(:active, false) if child.active?
  end

end