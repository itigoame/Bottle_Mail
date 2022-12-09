class NotificationsController < ApplicationController
  before_action :authenticate_member!

  def index
    @notifications = current_member.passive_notifications.page(params[:page]).per(10)
    @notifications = @notifications.where.not(visitor_id: current_member.id)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
      @visitor = notification.visitor
      @visited = notification.visited
      @action = notification.action
    end

  end

end
