require "test_helper"

class Api::V1::SleepsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    user = users(:user_one)
    get api_v1_user_sleeps_url(user_id: user.id)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]
    assert_equal 200, json_response["code"]
    assert_not_nil json_response["data"]
  end

  test "should create sleep record and clock-in" do
    user = users(:user_two)
    # Ensure a new sleep record is created when clocking in.
    assert_difference("Sleep.count") do
      post api_v1_user_sleeps_url(user_id: user.id)
    end
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]
    assert_equal 200, json_response["code"]
    assert_equal "Success clock-in", json_response["message"]
    assert_not_nil json_response["data"]
  end

  test "should update sleep record and clock-out" do
    user = users(:user_one)
    sleep = sleeps(:sleep_one)
    post api_v1_user_sleeps_url(user_id: user.id)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]
    assert_equal 200, json_response["code"]
    assert_equal "Success clock-out", json_response["message"]
    assert_not_nil json_response["data"]
    assert_not_nil sleep.reload.clock_out
  end

  test "should handle clock-out failure" do
    user = users(:user_one)
    Sleep.any_instance.stubs(:save).returns(false)
    post api_v1_user_sleeps_url(user_id: user.id)
    assert_response :error
    json_response = JSON.parse(response.body)
    assert_equal "error", json_response["status"]
    assert_equal 500, json_response["code"]
    assert_equal "Failed to clock-out", json_response["message"]
  end

  test "should handle clock-in failure" do
    user = users(:user_three)
    Sleep.any_instance.stubs(:save).returns(false)
    post api_v1_user_sleeps_url(user_id: user.id)
    assert_response :error
    json_response = JSON.parse(response.body)
    assert_equal "error", json_response["status"]
    assert_equal 500, json_response["code"]
    assert_equal "Failed to clock-in", json_response["message"]
  end

  test "should get following with valid data" do
    user = users(:user_one)
    get api_v1_user_following_sleeps_url(user_id: user.id)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]
    assert_equal 200, json_response["code"]
    assert_not_nil json_response["data"]
    assert json_response["data"].is_a?(Array)
  end

  test "should get empty following data if no followed users have sleep records" do
    user = users(:user_two)
    get api_v1_user_following_sleeps_url(user_id: user.id)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]
    assert_equal 200, json_response["code"]
    assert_empty json_response["data"]
  end

  test "should handle following when user does not exist" do
    get api_v1_user_following_sleeps_url(user_id: -1)
    assert_response :not_found
  end
end
