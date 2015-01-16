class DataUploadJob

  @queue = :parent
  def self.perform
    Miner.all.first(2).map { |miner|
      Resque.enqueue(DataUploadService, miner.id)
    }
  end

end