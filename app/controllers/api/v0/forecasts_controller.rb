class Api::V0::ForecastsController < ApplicationController

  def show
    coordinates = find_coordinates
    current_weather = get_current_weather(coordinates)
    binding.pry
  end

  private 
  def find_coordinates
    conn = Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.mapquest[:key]
    end
    response = conn.get("/geocoding/v1/address?location=#{params[:location]}")
    data = JSON.parse(response.body, symbolize_names: true)[:results].first[:locations].first[:latLng]
    data.map{|k,v| v.to_s}.join(",")
  end

  def get_current_weather(coordinates)
    conn = Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.weatherapi[:key]
    end
    response = conn.get("/v1/current.json?q=#{coordinates}")
    data = JSON.parse(response.body, symbolize_names: true)[:current]

    CurrentWeather.new(data).to_hash
  end
end