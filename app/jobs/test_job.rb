class TestJob < ApplicationJob

  def perform
    UserMailer.welcome(User.last).deliver
  end
end
