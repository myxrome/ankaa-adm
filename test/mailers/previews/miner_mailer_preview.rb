# Preview all emails at http://localhost:3000/rails/mailers/miner_mailer
class MinerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/miner_mailer/result_email
  def error_email
    MinerMailer.error_email
  end

end
