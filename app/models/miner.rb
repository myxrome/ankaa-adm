class Miner < ActiveRecord::Base
  belongs_to :category
  has_many :miner_scrapers, inverse_of: :miner, dependent: :destroy
  has_many :scrapers, through: :miner_scrapers
  before_save :init_name

  def init_name
    self.name ||= self.category.name
  end

end
