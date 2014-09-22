class MinerWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(1) }

  def perform
    Miner.all.each { |miner|
      miner.delay.perform
    }
  end

end