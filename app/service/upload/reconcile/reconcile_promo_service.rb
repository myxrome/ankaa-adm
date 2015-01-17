class ReconcilePromoService < BaseReconcileService

  def initialize(promo)
    @promo = promo
  end

  def reconcile(params, callback_context)
    @promo.assign_attributes(@promo.image.exists? ? params.except(:image) : params)
    @promo.save! if @promo.changed?
  end

end