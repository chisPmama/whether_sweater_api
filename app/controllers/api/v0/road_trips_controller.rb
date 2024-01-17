class Api::V0::RoadTripsController < ApplicationController
  before_action :authenticate_user

  def create
    conn = Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.mapquest[:key]
    end

    raw_data =  {
                  "locations": [
                                params[:origin],
                                params[:destination]
                               ]
                }
    json_string = JSON.generate(raw_data)
    headers = { 'Content-Type' => 'application/json' }
    response = conn.post("/directions/v2/route", json_string, headers)
    data = JSON.parse(response.body, symbolize_names: true)[:route]

    start_city = pretty_city(params[:origin])
    end_city = pretty_city(params[:destination])
    travel_time = data[:formattedTime]

    
    binding.pry
    # coordinates = find_coordinates
    # forecast = create_forecast(coordinates)
    # render json: ForecastSerializer.new(forecast)
  end

  private
  def user_params
    params.permit(:origin, :destination, :api_key)
  end

  def pretty_city(city)
    split = city.split(",")
    split[0] = split[0].scan(/[A-Z][a-z]*/)
    split[0] = split[0].join(" ")
    split = split.join(", ")
  end

  def authenticate_user
    user = User.find_by(api_key: params[:api_key])
    return error_response("Invalid API key.", 422) unless user.id == session[:user_id]
  end
end