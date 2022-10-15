require "test_helper"

class Admin::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_relationships_index_url
    assert_response :success
  end
end
