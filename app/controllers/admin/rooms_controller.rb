class Admin::RoomsController < ApplicationController
  before_action :authenticate_admin!
  def show
  end

  def index
  end
end
