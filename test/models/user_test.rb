require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_one)
  end

  test "should have many sleeps" do
    assert_respond_to @user, :sleeps
  end

  test "should have many follows" do
    assert_respond_to @user, :follows
  end

  test "should have many followed_users through follows" do
    assert_respond_to @user, :followed_users
  end

  test "should have many reverse_follows" do
    assert_respond_to @user, :reverse_follows
  end

  test "should have many followers through reverse_follows" do
    assert_respond_to @user, :followers
  end
end
