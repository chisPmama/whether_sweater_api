class Api::V0::ForecastsController < ApplicationController

  def show
    conn = Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.mapquest[:key]
    end
    response = conn.get("/geocoding/v1/address?location=#{params[:location]}")
    data = JSON.parse(response.body, symbolize_names: true)[:results].first[:locations].first[:latLng]

    coordinates = data.map do |coords|
      Coordinates.new(coords)
    end
  end

end