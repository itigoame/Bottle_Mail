require "test_helper"

class Member::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get member_members_show_url
    assert_response :success
  end

  test "should get edit" do
    get member_members_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get member_members_unsubscribe_url
    assert_response :success
  end
end
