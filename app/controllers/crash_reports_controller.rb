class CrashReportsController < ApplicationController
  before_action :set_crash_report, only: [:show, :destroy]

  # GET /crash_reports
  def index
    @crash_reports = CrashReport.all
  end

  # GET /crash_reports/1
  def show
  end

  # DELETE /crash_reports/1
  def destroy
    @crash_report.destroy
    redirect_to crash_reports_url, notice: 'Crash report was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_crash_report
    @crash_report = CrashReport.find(params[:id])
  end

end
