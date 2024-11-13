module Response
  extend ActiveSupport::Concern

  # json_response is following https://google.github.io/styleguide/jsoncstyleguide.xml
  def json_response(status:, code:, data: nil, error: nil, pagination: nil, meta: nil, message: nil)
    response = {
      status: status,
      code: code
    }
    response[:data] = data if data
    response[:error] = error if error
    response[:pagination] = pagination if pagination
    response[:meta] = meta if meta
    response[:message] = message if message

    render json: response, status: code
  end
end
