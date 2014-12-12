module Reconciler
  extend ActiveSupport::Concern

  def reconcile(params, callback_context)
  end

  def reconcile_associations(params, callback_context)
  end

  def on_create(child, callback_context)
  end

  def on_update(child, callback_context)
  end

  def on_delete(child, callback_context)
  end

  def on_error(e, callback_context)
    raise e
  end

  protected
  def reconcile_association(existing, params, callback_context)
    created_and_updated = bulk_create_or_update(existing, params, callback_context)
    deleted = existing.ids.to_set - created_and_updated.to_set
    bulk_delete(existing, deleted, callback_context)
  end

  def bulk_delete(existing, deleted, callback_context)
    deleted.each { |child_id|
      begin
        child = existing.find(child_id)
        on_delete(child, callback_context) if delete(child)
      rescue Exception => e
        on_error(e, callback_context)
      end
    }
  end

  def bulk_create_or_update(existing, params, callback_context)
    params.map { |p|
      begin
        child = existing.find_or_initialize_by(source: p[:source])
        child.reconcile(p, callback_context)
        if child.changed?
          if child.new_record?
            on_create(child, callback_context)
          else
            on_update(child, callback_context)
          end
          child.save!
        end
        child.reconcile_associations(p, callback_context)
        child.id
      rescue Exception => e
        on_error(e, callback_context)
      end
    }
  end

  def delete(child)
    child.destroy
  end

end