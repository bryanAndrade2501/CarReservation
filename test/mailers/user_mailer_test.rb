require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "recover" do
    mail = UserMailer.recover
    assert_equal "Recover", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
