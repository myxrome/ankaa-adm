class ReconcileValueService < BaseReconcileService

  def initialize(value)
    @value = value
  end

  def reconcile(params)
    @value.assign_attributes(params.except(:descriptions_attributes, :promos_attributes))
    @value.assign_attributes(active: !@value.url.blank?)
    @value.save! if @value.changed?
  end

  def reconcile_associations(params)
    reconcile_association(@value.descriptions, params[:descriptions_attributes]) { |description|
      ReconcileDescriptionService.new(description)
    }
    reconcile_association(@value.promos, params[:promos_attributes].sort_by { |v| v[:order] }.first(7)) { |promo|
      ReconcilePromoService.new(promo)
    }
  end

end