class MinerMailer < ActionMailer::Base
  default from: 'myxrome@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.miner_mailer.result_email.subject
  #
  def result_email(miner, result)
    @miner = miner
    @result = result
    mail subject: "[MINER #{miner.name}] Mining Results", to: 'myxrome@outlook.com'
  end

end
