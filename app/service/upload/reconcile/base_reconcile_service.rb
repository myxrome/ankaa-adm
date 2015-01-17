class BaseReconcileService

  def reconcile(params)
  end

  def reconcile_associations(params)
  end

  protected
  def reconcile_association(existing, params)
    created_and_updated = params.map { |p|
      begin
        child = existing.find_or_initialize_by(source: p[:source])

        if block_given?
          reconciler = yield(child)
          if reconciler
            reconciler.reconcile(p)
            reconciler.reconcile_associations(p)
          end
        end

        child.id
      rescue Exception => e
        UploadErrorReportingService.instance.on_error(e)
      end
    }

    lost = existing.ids.to_set - created_and_updated.to_set
    lost.each { |child_id|
      begin
        child = existing.find(child_id)
        child.update_attribute(:active, false) if child.active?
      rescue Exception => e
        UploadErrorReportingService.instance.on_error(e)
      end
    }
  end

end