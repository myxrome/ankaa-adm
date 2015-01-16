class DataUploadService

  @queue = :child

  def self.perform(miner_id)

    miner = Miner.find(miner_id)
    unless miner.miner_scrapers.empty?
      # ResultMailingService.instance.error_message(" - miner #{miner_id}")
      service = MiningService.new(miner)
      data = service.perform
      # miner.category.reconcile(source, self) if source
      # MinerMailer.result_email(self, @result).deliver
    end

  end

end