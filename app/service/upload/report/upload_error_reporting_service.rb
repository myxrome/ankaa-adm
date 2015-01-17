class UploadErrorReportingService
  include Singleton

  def initialize
    @reports = Hash.new
  end

  def on_error(e)
    @reports[key] = {error: []} unless @reports.key?(key)
    @reports[key][:error] << (["#{e.message}:"] << e.backtrace).flatten
  end

  def report(miner)
    if @reports.key?(key)
      MinerMailer.error_email(miner, @reports[key][:error]).deliver unless @reports[key][:error].empty?
      @reports.delete(key)
    end
  end

  private
  def key
    Process.pid
  end

end