class Api::V1::MunchiesController < Api::V0::ForecastsController
  def show
    coordinates = find_coordinates.split(",")
    coordinates = {lat: coordinates[0], lon: coordinates[1]}

    munchie = create_munchie(coordinates)
    render json: MunchieSerializer.new(munchie)
  end
  
  private
  def pretty_destination
    destination = params[:destination].upcase.split(",")
    destination[0] = destination[0].capitalize
    destination.join(", ")
  end

  def get_restaurant(coordinates, type)
    conn = Faraday.new(url:"https://api.yelp.com") do |faraday|
      faraday.params["Authorization"] = Rails.application.credentials.yelp[:key]
    end
    response = conn.get("/v3/businesses/search?latitude=#{coordinates[:lat]}&longitude=#{coordinates[:lon]}term=#{type}limit=10")
    data = JSON.parse(response.body, symbolize_names: true)[:businesses]
  
    Restaurant.new(data.sample).to_hash
  end

  def get_forecast
    data = WeatherFacade.new.get_current_weather(find_coordinates)
    {summary: data[:condition], temperature: data[:temperature].to_s}
  end

  def create_munchie(coordinates)
    destination_city = pretty_destination
    restaurant = get_restaurant(coordinates, params[:food])
    forecast = get_forecast

    Munchie.new(destination_city, restaurant, forecast)
  end
end