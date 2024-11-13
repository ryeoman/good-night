class Api::V1::FollowsController < ApplicationController
  include Response

  def index
    user = User.find_by(id: params[:user_id])
    json_response(
        status: "success",
        code: 200,
        data: user.followed_users
      )
  end

  def create
    user_id = params[:user_id]
    following_id = params[:following_user_id]

    existing_follow = Follow.find_by(user_id: user_id, following_id: following_id)
    if existing_follow
      json_response(
        status: "error",
        code: 409,
        message: "User is already followed",
      )
      return
    end

    follow = Follow.new(user_id: user_id, following_id: following_id)
    if follow.save()
      json_response(
        status: "success",
        code: 200,
        data: follow,
      )
      return
    end

    json_response(
      status: "error",
      code: 500,
      message: "Failed to follow",
    )
  end

  def destroy
    user_id = params[:user_id]
    following_id = params[:following_user_id]

    existing_follow = Follow.find_by(user_id: user_id, following_id: following_id)
    if existing_follow && existing_follow.destroy
      json_response(
        status: "success",
        code: 200,
        message: "Success unfollow"
      )
      return
    end
    json_response(
      status: "error",
      code: 500,
      message: "Failed unfollow"
    )
  end
end
