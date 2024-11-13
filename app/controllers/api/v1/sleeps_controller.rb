require "time_formatter"
class Api::V1::SleepsController < ApplicationController
  include Response
  include TimeFormatter

  def index
    json_response(
      status: "success",
      code: 200,
      data: Sleep.where(user_id: params[:user_id]).order(:created_at)
    )
  end

  def create
    # check if there is outstanding record
    latest_sleep = Sleep.where(user_id: params[:user_id]).order(clock_in: :desc).first
    if latest_sleep && latest_sleep.clock_out.nil?
      latest_sleep.clock_out = Time.current
      latest_sleep.duration = (latest_sleep.clock_out - latest_sleep.clock_in).to_i
      if latest_sleep.save
        json_response(
          status: "success",
          code: 200,
          data: latest_sleep,
          message: "Success clock-out"
        )
        return
      end
      json_response(
        status: "error",
        code: 500,
        message: "Failed to clock-out"
      )
      return
    end

    sleep = Sleep.new(user_id: params[:user_id], clock_in: Time.current)
    if sleep.save!()
      json_response(
        status: "success",
        code: 200,
        data: sleep,
        message: "Success clock-in"
      )
      return
    end

    json_response(
      status: "error",
      code: 500,
      message: "Failed to clock-in"
    )
  end

  def following
    user = User.find_by(id: params[:user_id])
    followed_user = user.followed_users
    sleeps = Sleep.where(user_id: followed_user.pluck(:id))
            .where("clock_in >= ?", 7.days.ago)
            .where.not(duration: nil)
            .order(duration: :desc)
            .includes(:user)

    timeline = sleeps.map do |sleep|
      {
        user_name: sleep.user.name,
        duration: sleep.duration,
        formatted_duration: TimeFormatter.format(sleep.duration)
      }
    end

    json_response(
      status: "success",
      code: 200,
      data: timeline
    )
  end
end
