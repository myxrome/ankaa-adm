class DataUploadJob

  @queue = :parent
  def self.perform
    Miner.all.map { |miner|
      Resque.enqueue(DataUploadService, miner.id)
    }
  end

end