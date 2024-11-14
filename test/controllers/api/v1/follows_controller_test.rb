require "test_helper"

class Api::V1::FollowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)
    @followed_user = users(:user_two)
    @user.followed_users << @followed_user
    @not_followed_user = users(:user_four)
  end

  # index controller
  test "should get index" do
    get api_v1_user_follows_url(@user), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]
    assert_equal 200, json_response["code"]
    assert_equal @user.followed_users.count, json_response["data"].count
  end

  test "should return error if user not found" do
    get api_v1_user_follows_url(user_id: -1), as: :json
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal "error", json_response["status"]
    assert_equal 404, json_response["code"]
    assert_equal "User not found", json_response["message"]
  end

  # create controller
  test "should create follow" do
    assert_difference("Follow.count") do
      post follow_action_api_v1_user_follows_url(@user, @not_followed_user)
    end
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]
    assert_equal 200, json_response["code"]
    assert_not_nil json_response["data"]
  end

  test "should not create follow if already followed" do
    post follow_action_api_v1_user_follows_url(@user, @followed_user)
    assert_response :conflict

    json_response = JSON.parse(response.body)
    assert_equal "error", json_response["status"]
    assert_equal 409, json_response["code"]
    assert_equal "User is already followed", json_response["message"]
  end

  test "should return error if follow creation fails" do
    Follow.any_instance.stubs(:save).returns(false)
    post follow_action_api_v1_user_follows_url(@user, @not_followed_user)
    assert_response :error

    json_response = JSON.parse(response.body)
    assert_equal "error", json_response["status"]
    assert_equal 500, json_response["code"]
    assert_equal "Failed to follow", json_response["message"]
  end

  # destroy controller
  test "should destroy follow" do
    assert_difference("Follow.count", -1) do
      delete unfollow_action_api_v1_user_follows_url(@user, @followed_user)
    end
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal "success", json_response["status"]
    assert_equal 200, json_response["code"]
    assert_equal "Success unfollow", json_response["message"]
  end

  test "should return error if follow does not exist" do
    delete unfollow_action_api_v1_user_follows_url(@user, @not_followed_user)
    assert_response :error

    json_response = JSON.parse(response.body)
    assert_equal "error", json_response["status"]
    assert_equal 500, json_response["code"]
    assert_equal "Failed unfollow", json_response["message"]
  end
end
