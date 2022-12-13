class NotificationsController < ApplicationController
  before_action :authenticate_member!

  def index
    @notifications = current_member.passive_notifications.page(params[:page]).per(20).order(id: "DESC")
    @notifications = @notifications.where.not(visitor_id: current_member.id)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
      @visitor = notification.visitor
      @visited = notification.visited
      @action = notification.action
    end

  end

  # def destroy_all
  #   # 通知を全削除
  #   notifications = current_member.passive_notifications.destroy_all
  #   redirect_to notifications_path
  # end

end
