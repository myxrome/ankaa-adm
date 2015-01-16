class DataUploadService

  @queue = :child

  def self.perform(miner_id)

    miner = Miner.find(miner_id)
    unless miner.miner_scrapers.empty?
      service = MiningService.new(miner)
      data = service.perform
      # miner.category.reconcile(source, self) if source
      UploadErrorReportingService.instance.report(miner)
    end

  end

end