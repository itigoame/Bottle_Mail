require "test_helper"

class Member::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get member_homes_top_url
    assert_response :success
  end

  test "should get about" do
    get member_homes_about_url
    assert_response :success
  end
end
