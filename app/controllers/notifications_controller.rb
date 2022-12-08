class NotificationsController < ApplicationController
  def index
    @notifications = current_member.passive_notifications.all
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
      @visitor = notification.visitor
      @visited = notification.visited
    end

  end
end
