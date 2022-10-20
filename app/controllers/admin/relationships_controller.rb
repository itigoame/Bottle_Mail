class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
end
