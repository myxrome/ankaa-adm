class MinerWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: false
  recurrence { hourly }

  def perform
    Miner.all.map { |miner|
      miner.delay.perform
    }
  end

end