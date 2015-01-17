class ReconcileCategoryService < BaseReconcileService

  def initialize(category)
    @category = category
  end

  def reconcile(params)
    reconcile_associations(params)
  end

  def reconcile_associations(params)
    reconcile_association(@category.values, params) { |value|
      ReconcileValueService.new(value)
    }
  end

end