class Api::V0::RoadTripsController < Api::V0::ForecastsController
  before_action :authenticate_user

  def create
    origin = params[:origin]
    destination = params[:destination]

    @facade = RoadTripFacade.new
    @road_trip = @facade.get_road_trip(origin, destination)

    render json: RoadTripSerializer.new(@road_trip)
  end

  private
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