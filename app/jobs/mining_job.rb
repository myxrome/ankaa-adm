class MiningJob

  @queue = :parent
  def self.perform
    Miner.all.map { |miner|
      Resque.enqueue(Miner, miner.id)
    }
  end

end