require "test_helper"

class Member::RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get member_rooms_show_url
    assert_response :success
  end

  test "should get index" do
    get member_rooms_index_url
    assert_response :success
  end
end
