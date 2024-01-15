class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather

  def initialize(current, daily, hourly)
    @current_weather = current
    @daily_weather = daily
    @hourly = hourly
  end
  
end