class Api::V0::ForecastsController < ApplicationController
  def show
    coordinates = find_coordinates
    forecast = create_forecast(coordinates)
    render json: ForecastSerializer.new(forecast)
  end

  def current_weather(coordinates)
    WeatherFacade.new.get_current_weather(coordinates)
  end

  private
  def hourly_weather(coordinates)
    WeatherFacade.new.get_hourly_weather(coordinates)
  end

  def daily_weather(coordinates)
    WeatherFacade.new.get_daily_weather(coordinates)
  end

  def create_forecast(coordinates)
    current = current_weather(coordinates)
    daily = daily_weather(coordinates)
    hourly = hourly_weather(coordinates)

    Forecast.new(current, daily, hourly)
  end
end