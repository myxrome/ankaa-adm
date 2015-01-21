class DataUploadJob

  @queue = :parent
  def self.perform
    Miner.includes(:category).all.map { |miner|
      Resque.enqueue(DataUploadService, miner.id) if miner.category.active?
    }
  end

end