class Application < ActiveRecord::Base
  has_many :application_categories, inverse_of: :application, dependent: :destroy
  has_many :categories, through: :application_categories
  has_many :values, -> { where('values.active = true and values.end_date > ?', DateTime.now.to_date) },
           through: :categories
  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

end
