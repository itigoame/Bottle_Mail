class Member::EntriesController < ApplicationController
  before_action :authenticate_member!
end
