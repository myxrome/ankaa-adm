class DataUploadService

  @queue = :child

  def self.perform(miner_id)
    miner = Miner.find(miner_id)
    unless miner.miner_scrapers.empty?
      data = mine_data(miner)
      recincile_data(data, miner)
      UploadErrorReportingService.instance.report(miner)
    end
  end

  def self.recincile_data(data, miner)
    if data
      service = ReconcileCategoryService.new(miner.category)
      service.reconcile(data)
    end
  end

  def self.mine_data(miner)
    service = MiningService.new(miner)
    service.perform
  end

end