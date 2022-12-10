class Member::ReportsController < ApplicationController

  before_action :authenticate_member!

  def new
    @report = Report.new
    @member = Member.find(params[:member_id])
  end

  def create
    @member = Member.find(params[:member_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_member.id
    @report.reported_id = @member.id
    if @report.save
      redirect_to member_path(@member),notice: "ご報告ありがとうございます"
    else
      flash[:report_create_alert] = '送信がうまく行われませんでした。お手数ですが再度お試しください。'
      redirect_to new_member_report_path
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason)
  end
end
