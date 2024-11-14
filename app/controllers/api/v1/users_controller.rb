class Api::V1::UsersController < ApplicationController
  include Response

  def show
    user = User.find_by(id: params[:id])
    if user.nil?
      json_response(
        status: "error",
        code: 404,
        message: "User not found"
      )
      return
    end

    json_response(
      status: "success",
      code: 200,
      data: User.find_by(id: params[:id])
    )
  end
end
