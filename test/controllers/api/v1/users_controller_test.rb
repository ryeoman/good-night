require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)
  end

  test "should show user" do
    get api_v1_user_url(@user)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]
    assert_equal 200, json_response["code"]
    assert_equal @user.id, json_response["data"]["id"]
  end

  test "should return not found for invalid user" do
    get api_v1_user_url(id: -1)
    assert_response :not_found
  end
end
