require "test_helper"

class RentalRequestMailerTest < ActionMailer::TestCase
  test "ask" do
    mail = RentalRequestMailer.ask
    assert_equal "Ask", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
