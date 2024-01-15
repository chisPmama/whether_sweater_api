require 'rails_helper'

RSpec.describe "Forecast", type: :request do
  before :each do
    get "/api/v0/forecast?location=minneapolis,mn"
    expect(response).to be_successful
    @mpls_forecast = JSON.parse(response.body, symbolize_names: true)[:data]
  end

  describe "get forecast data based on the city and state inputted" do
    it 'can return a successful response that covers the first basic keys of id, type, and attributes' do
      expect(@mpls_forecast).to have_key(:id)
      expect(@mpls_forecast).to have_key(:type)
      expect(@mpls_forecast[:type]).to eq("forecast")
      expect(@mpls_forecast).to have_key(:attributes)
    end

    it 'contains current_weather as an attribute that holds the last_updated etc info' do
      expect(@mpls_forecast[:attributes]).to have_key(:current_weather)
      expect(@mpls_forecast[:attributes]).to be_a(Hash)

      current = @mpls_forecast[:attributes][:current_weather]
      
      expect(current).to have_key(:last_updated)
      expect(current[:last_updated]).to be_a(String)

      expect(current).to have_key(:temperature)
      expect(current[:temperature]).to be_a(Float)

      expect(current).to have_key(:feels_like)
      expect(current[:feels_like]).to be_a(Float)

      expect(current).to have_key(:humidity)
      expect(current[:humidity]).to be_a(Integer)

      expect(current).to have_key(:uvi)
      expect(current[:uvi]).to be_a(Float)

      expect(current).to have_key(:visibility)
      expect(current[:visibility]).to be_a(Float)

      expect(current).to have_key(:condition)
      expect(current[:condition]).to be_a(String)

      expect(current).to have_key(:icon)
      expect(current[:icon]).to be_a(String)

    end

    xit 'contains daily_weather as an attribute that is an array of the next 5 days of data' do

    end

    xit 'contains hourly_weather as an attribute that is an array of all 24 hours of hourly data for the current day' do

    end
  end

end