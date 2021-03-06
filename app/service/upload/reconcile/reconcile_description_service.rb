class ReconcileDescriptionService < BaseReconcileService

  def initialize(description)
    @description = description
  end

  def reconcile(params)
    @description.assign_attributes(params)
    @description.assign_attributes(active: true)
    @description.save! if @description.changed?
  end

end