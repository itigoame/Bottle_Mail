class ReportMailer < ApplicationMailer

  def send_mail(report)
  @report = report
  mail(
    from: "system.@test.com",
    to: "44610nemoto@gmail.com",
    subject: "通報がありました"
  )
  end
end
