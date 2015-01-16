class MiningService

  def initialize(miner)
    @miner = miner
  end

  def perform
    @miner.miner_scrapers.map { |miner_scraper|
      service = ScrapingService.new(miner_scraper)
      service.perform
    }.flatten
  end

  # attr_accessor :result
  # after_initialize :init_result
  # def init_result
  #   self.result = {new: [], updated: [], deleted: [], error: []}
  # end
  #
  # def on_new(item)
  #   self.result[:new] << item unless self.result[:new].include?(item)
  # end
  #
  # def on_update(item)
  #   self.result[:updated] << item unless self.result[:new].include?(item) && self.result[:updated].include?(item)
  # end
  #
  # def on_delete(item)
  #   self.result[:deleted] << item
  # end
  #
  # def on_error(message)
  #   self.result[:error] << message
  # end

end