class Miner < ActiveRecord::Base
  belongs_to :category
  has_many :miner_scrapers, inverse_of: :miner, dependent: :destroy
  has_many :scrapers, through: :miner_scrapers

  @queue = :child
  def self.perform(id)
    Miner.find(id).perform
  end

  attr_accessor :result
  after_initialize :init_result
  def init_result
    self.result = {new: [], updated: [], deleted: [], error: []}
  end

  #COUNT=2 QUEUE=child,parent rake resque:workers, rake resque:scheduler
  def perform
    source = self.miner_scrapers.map { |miner_scraper|
      miner_scraper.scraper.perform(self, miner_scraper)
    }.flatten
    category.reconcile(self, source) if source
    MinerMailer.result_email(self, @result).deliver
  end

  def on_new(item)
    self.result[:new] << item
  end

  def on_update(item)
    self.result[:updated] << item
  end

  def on_delete(item)
    self.result[:deleted] << item
  end

  def on_error(message)
    self.result[:error] << message
  end

end
