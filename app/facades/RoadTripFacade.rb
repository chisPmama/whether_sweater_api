class RoadTripFacade < ApplicationController
  def get_road_trip(origin, destination)
    @service = RoadTripService.new
    @directions = parse_json(@service.find_directions(origin, destination), origin, destination)
  end

  def parse_json(data, origin, destination)
    check_data = JSON.parse(data.body, symbolize_names: true)
    if check_data[:info][:statuscode] == 402
      return
    end
  
    data = JSON.parse(data.body, symbolize_names: true)[:route]
  
    start_city = pretty_city(origin)
    end_city = pretty_city(destination)
    travel_time = data[:formattedTime]
  
    travel_sec = data[:time]
    dest_coordinates = find_coordinates(end_city)
  
    weather_at_eta = find_weather_at_eta(travel_time, calculate_eta(travel_sec), dest_coordinates)
  
    roadtrip = RoadTrip.new(start_city, end_city, travel_time, weather_at_eta)
  end
  

private
  def pretty_city(city)
    split = city.split(",")
    split[0] = split[0].scan(/[A-Z][a-z]*/)
    split[0] = split[0].join(" ")
    split = split.join(", ")
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