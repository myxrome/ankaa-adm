class Application < ActiveRecord::Base
  has_many :application_categories
  has_many :categories, through: :application_categories
  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

end
