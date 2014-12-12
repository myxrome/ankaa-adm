require 'reconcile/reconciler'

require 'reconcile/category_reconciler'
require 'reconcile/value_reconciler'
require 'reconcile/description_reconciler'
require 'reconcile/promo_reconciler'

AnkaaContent::Category.send(:include, CategoryReconciler)
AnkaaContent::Value.send(:include, ValueReconciler)
AnkaaContent::Description.send(:include, DescriptionReconciler)
AnkaaContent::Promo.send(:include, PromoReconciler)