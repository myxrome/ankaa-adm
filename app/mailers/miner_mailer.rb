class MinerMailer < ActionMailer::Base
  default from: 'robot@whiteboxteam.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.miner_mailer.result_email.subject
  #
  def error_email(miner, errors)
    @miner = miner
    @errors = errors
    mail subject: "[MINER #{miner.name}] Mining Errors", to: 'mining@whiteboxteam.com'
  end

end
