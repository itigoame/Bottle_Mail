class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin!
end
