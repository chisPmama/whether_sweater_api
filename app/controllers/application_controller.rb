class ApplicationController < ActionController::API
  def error_response(message, status)
    render json: ErrorSerializer.new(ErrorMessage.new(message, status))
    .serialize_json, status: :unprocessable_entity
  end

  def find_coordinates(location)
    CoordinateFacade.new.get_coordinates(location)
  end
end
