class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @reports = Report.all.page(params[:page]).per(20).order(id: "DESC")
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    report = Report.find(params[:id])
    if report.update(report_params)
      redirect_to request.referer
    end
  end

  private

  def report_params
    params.require(:report).permit(:dealt_with)
  end
end
