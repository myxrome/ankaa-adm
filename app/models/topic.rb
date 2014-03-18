class Topic < ActiveRecord::Base
  has_many :topic_categories, inverse_of: :topic, dependent: :destroy
  has_many :categories, through: :topic_categories
  has_many :values, -> { where('values.active = true and values.end_date > ?', DateTime.now.to_date) },
           through: :categories
  after_initialize :init_key

  def init_key
    self.key ||= SecureRandom.hex
  end

end
