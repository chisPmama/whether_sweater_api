class Api::V0::ForecastsController < ApplicationController

  def show
    coordinates = find_coordinates
  end

  private 
  def find_coordinates
    conn = Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.mapquest[:key]
    end
    response = conn.get("/geocoding/v1/address?location=#{params[:location]}")
    data = JSON.parse(response.body, symbolize_names: true)[:results].first[:locations].first[:latLng]
    Coordinates.new(data)
  end

end