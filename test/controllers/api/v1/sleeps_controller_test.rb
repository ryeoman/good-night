require "test_helper"

class Api::V1::SleepsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_sleeps_index_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_sleeps_create_url
    assert_response :success
  end

  test "should get following" do
    get api_v1_sleeps_following_url
    assert_response :success
  end
end
