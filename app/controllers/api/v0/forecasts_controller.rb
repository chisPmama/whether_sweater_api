class Api::V0::ForecastsController < ApplicationController
  def show
    coordinates = find_coordinates
    @forecast = create_forecast(coordinates)
  end

  private 
  def find_coordinates
    location = params[:location]
    @facade = CoordinateFacade.new
    @coordinates = @facade.get_coordinates(location)
  end

  def get_current_weather(coordinates)
    conn = Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.weatherapi[:key]
    end
    response = conn.get("/v1/current.json?q=#{coordinates}")
    data = JSON.parse(response.body, symbolize_names: true)[:current]

    CurrentWeather.new(data).to_hash
  end

  def get_hourly_weather(coordinates)
    conn = Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.weatherapi[:key]
    end
    response = conn.get("/v1/forecast.json?q=#{coordinates}")
    data = JSON.parse(response.body, symbolize_names: true)[:forecast][:forecastday].first

    HourlyWeather.new(data).to_array
  end

  def get_daily_weather(coordinates)
    conn = Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.weatherapi[:key]
    end
    response = conn.get("/v1/forecast.json?q=#{coordinates}&days=5") ## can use this same call for hourly_data to save API calls
    data = JSON.parse(response.body, symbolize_names: true)[:forecast][:forecastday]
    DailyWeather.new(data).to_array
  end

  def create_forecast(coordinates)
    current = get_current_weather(coordinates)
    daily = get_daily_weather(coordinates)
    hourly = get_hourly_weather(coordinates)

    forecast = Forecast.new(current, daily, hourly)
    render json: forecast.to_json
  end
end