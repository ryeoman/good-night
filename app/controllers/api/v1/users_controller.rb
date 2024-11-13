class Api::V1::UsersController < ApplicationController
  include Response

  def show
    json_response(
      status: "success",
      code: 200,
      data: User.find_by(id: params[:id])
    )
  end
end
