class Application < ActiveRecord::Base
  has_many :application_categories
  has_many :categories, through: :application_categories

  after_initialize do |application|
    application.key = SecureRandom.hex
  end

end
