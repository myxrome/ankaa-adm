class MinerMailer < ActionMailer::Base
  default from: 'myxrome@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.miner_mailer.result_email.subject
  #
  def result_email(result)
    @result = result.map { |miner_id, value|
      {Miner.find(miner_id) => value.map { |key, values|
        {key => values.map { |source|
          v = Value.find_by(source: source)
          {(root_path + value_path(v)) => v.name}
        }.reduce(:merge)}
      }.reduce(:merge)
      }
    }.reduce(:merge)
    mail subject: 'Mining Results', to: 'myxrome@outlook.com'
  end

end
