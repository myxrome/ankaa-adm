class Application < ActiveRecord::Base
  after_initialize do |application|
    application.key = SecureRandom.hex
  end

end
