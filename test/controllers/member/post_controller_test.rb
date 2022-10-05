require "test_helper"

class Member::PostControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get member_post_new_url
    assert_response :success
  end

  test "should get show" do
    get member_post_show_url
    assert_response :success
  end

  test "should get index" do
    get member_post_index_url
    assert_response :success
  end
end
