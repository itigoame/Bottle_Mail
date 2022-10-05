require "test_helper"

class Member::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get member_categories_index_url
    assert_response :success
  end
end
