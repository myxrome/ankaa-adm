require 'test_helper'

class MinerMailerTest < ActionMailer::TestCase
  test "result_email" do
    mail = MinerMailer.result_email
    assert_equal "Result email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
