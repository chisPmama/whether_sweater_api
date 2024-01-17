class ApplicationController < ActionController::API
  def error_response(message, status)
    render json: ErrorSerializer.new(ErrorMessage.new(message, status))
    .serialize_json, status: :unprocessable_entity
  end
end
