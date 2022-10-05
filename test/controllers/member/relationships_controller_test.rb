require "test_helper"

class Member::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_relationships_index_url
    assert_response :success
  end
end
