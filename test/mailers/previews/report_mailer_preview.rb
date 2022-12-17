# Preview all emails at http://localhost:3000/rails/mailers/report_mailer
class ReportMailerPreview < ActionMailer::Preview
  def report
    report = Report.new(reported_id: 1,reporter_id: 2,reason: "テスト送信テスト送信")
    ReportMailer.send_mail(report)
  end
end
