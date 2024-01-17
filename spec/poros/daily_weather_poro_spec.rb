require "rails_helper"

RSpec.describe DailyWeather do
  xit "exists" do
    data = {:last_updated_epoch=>1705312800,
            :last_updated=>"2024-01-15 04:00",
            :temp_c=>-21.7,
            :temp_f=>-7.1,
            :is_day=>0,
            :condition=>{:text=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/night/116.png", :code=>1003},
            :wind_mph=>8.1,
            :wind_kph=>13.0,
            :wind_degree=>270,
            :wind_dir=>"W",
            :pressure_mb=>1022.0,
            :pressure_in=>30.19,
            :precip_mm=>0.0,
            :precip_in=>0.0,
            :humidity=>71,
            :cloud=>25,
            :feelslike_c=>-30.7,
            :feelslike_f=>-23.3,
            :vis_km=>13.0,
            :vis_miles=>8.0,
            :uv=>1.0,
            :gust_mph=>11.9,
            :gust_kph=>19.1}

    daily_weather = DailyWeather.new(data)

    expect(daily_weather).to be_a DailyWeather
    expect(daily_weather.last_updated).to eq("2024-01-15 04:00")
    expect(daily_weather.temperature).to eq(-7.1)
    expect(daily_weather.feels_like).to eq(-23.3)
    expect(daily_weather.humidity).to eq(71)
    expect(daily_weather.uvi).to eq(1.0)
    expect(daily_weather.visibility).to eq(8.0)
    expect(daily_weather.condition).to eq("Partly cloudy")
    expect(daily_weather.icon).to eq("//cdn.weatherapi.com/weather/64x64/night/116.png")
  end
end