class ReconcilePromoService < BaseReconcileService

  def initialize(promo)
    @promo = promo
  end

  def reconcile(params)
    @promo.assign_attributes(@promo.image.exists? ? params.except(:image) : params)
    @promo.assign_attributes(active: true)
    @promo.save! if @promo.changed?
  end

end