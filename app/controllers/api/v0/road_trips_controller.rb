class Api::V0::RoadTripsController < Api::V0::ForecastsController
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

    travel_sec = data[:time]
    dest_coordinates = find_coordinates(end_city)

    ## impossible route possibility
    weather_at_eta = find_weather_at_eta(travel_time, calculate_eta(travel_sec), dest_coordinates)

    roadtrip = RoadTrip.new(start_city, end_city, travel_time, weather_at_eta)
    render json: RoadTripSerializer.new(roadtrip)
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

  def calculate_eta(travel_sec)
    current_time = Time.now
    eta = current_time + travel_sec
    pretty_eta = eta.strftime("%Y-%m-%d %H:%M")
  end

  def find_weather_at_eta(travel_time, datetime, dest_coordinates)
    WeatherFacade.new.get_eta_weather(travel_time, datetime, dest_coordinates)
  end
end