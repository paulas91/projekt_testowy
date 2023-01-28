class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.unread
  end

  def all
    @notifications = current_user.notifications
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.update(read_at: Time.now)
    redirect_to notifications_path
  end
end
