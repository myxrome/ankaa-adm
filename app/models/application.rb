class Application < ActiveRecord::Base
  has_many :application_categories
  has_many :categories, through: :application_categories
  has_many :values, -> { where('values.end_date > ?', DateTime.now.to_date) }, through: :categories
  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

end
