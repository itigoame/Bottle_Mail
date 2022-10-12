class Member::EntriesController < ApplicationController
  belongs_to :member
  belongs_to :room
end
