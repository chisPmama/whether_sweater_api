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

  def current_weather(coordinates)
    @facade = WeatherFacade.new
    @current = @facade.get_current_weather(coordinates)
  end

  def hourly_weather(coordinates)
    @facade = WeatherFacade.new
    @hourly = @facade.get_hourly_weather(coordinates)
  end

  def daily_weather(coordinates)
    @facade = WeatherFacade.new
    @daily = @facade.get_daily_weather(coordinates)
  end

  def create_forecast(coordinates)
    current = current_weather(coordinates)
    daily = daily_weather(coordinates)
    hourly = hourly_weather(coordinates)

    forecast = Forecast.new(current, daily, hourly)
    render json: 
    ForecastSerializer.new(forecast)
  end
end