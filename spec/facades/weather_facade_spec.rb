require "rails_helper"

RSpec.describe WeatherFacade do  
  it "can collect the current_weather attributes" do
    coordinates = "44.97902,-93.26494"
    current = WeatherFacade.new.get_current_weather(coordinates)

    expect(current).to be_a(Hash)
    expect(current.keys).to eq([:condition, :feels_like, :humidity, :icon, :last_updated, :temperature, :uvi, :visibility])
  end

  it "can collect the hourly_weather attributes" do
    coordinates = "44.97902,-93.26494"
    hourly = WeatherFacade.new.get_hourly_weather(coordinates)

    expect(hourly).to be_an(Array)
    expect(hourly.count).to eq(24)
    expect(hourly.first.keys).to eq([:time, :temperature, :conditions, :icon])
  end

  it "can collect the daily_weather attributes" do
    coordinates = "44.97902,-93.26494"
    daily = WeatherFacade.new.get_daily_weather(coordinates)

    expect(daily).to be_an(Array)
    expect(daily.count).to eq(5)
    expect(daily.first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])
  end
end