class ReportingService
  include Singleton

  def initialize
    @reports = Hash.new
  end

  def on_error(e)
    @reports[key] = {new: [], updated: [], deleted: [], error: []} unless @reports.key?(key)
    @reports[key][:error] << e.message
  end

  def report(miner)
    if @reports.key?(key)
      MinerMailer.result_email(miner, @reports[key]).deliver unless @reports[key][:error].empty?
      @reports.delete(key)
    end
  end

  private
  def key
    Process.pid
  end

end