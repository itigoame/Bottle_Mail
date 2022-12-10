class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Member"
  belongs_to :reported, class_name: "Member"

  validates :reason, presence: true, length: { minimum: 10, maximum: 500 }

  def status_check
    if dealt_with == false
      "未"
    else
      "済"
    end
  end
end
