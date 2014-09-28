class MinerWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: false
  recurrence { minutely(5) }

  def perform
    Sidekiq::Queue.new.clear
    result = Miner.all.map { |miner|
      out = Hash(new: Array.new, update: Array.new, delete: Array.new)
      {miner.id => miner.perform(out)}
    }.reduce(:merge)
    MinerMailer.result_email(result).deliver!
  end

end