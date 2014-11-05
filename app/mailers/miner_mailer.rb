class MinerMailer < ActionMailer::Base
  default from: 'myxrome@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.miner_mailer.result_email.subject
  #
  def result_email(miner, result)
    @miner = miner
    @result = result.except(:error).map { |key, values|
      {key => values.map { |value|
        {(value_url(value)) => ('!!! ' unless value.active) + value.name}
      }.reduce(:merge)}
    }.reduce(:merge)
    @error = result[:error]
    mail subject: 'Mining Results', to: 'myxrome@outlook.com'
  end

end
