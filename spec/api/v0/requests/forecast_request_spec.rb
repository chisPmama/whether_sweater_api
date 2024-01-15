require 'rails_helper'

RSpec.describe "Forecast", type: :request do
  before :each do
    stub_mapquest
    stub_weatherapi

    get "/api/v0/forecast?location=minneapolis,mn"
    expect(response).to be_successful
    @mpls_forecast = JSON.parse(response.body, symbolize_names: true)[:data]
    @attributes = @mpls_forecast[:attributes]
  end

  describe "get forecast data based on the city and state inputted" do
    it 'can return a successful response that covers the first basic keys of id, type, and attributes' do
      expect(@mpls_forecast).to have_key(:id)
      expect(@mpls_forecast).to have_key(:type)
      expect(@mpls_forecast[:type]).to eq("forecast")
      expect(@mpls_forecast).to have_key(:attributes)
    end
    
    it "has three attributes of daily, hourly, and current weather" do
      expect(@attributes).to have_key(:daily_weather)
      expect(@attributes).to have_key(:hourly_weather)
      expect(@attributes).to have_key(:current_weather)
    end

    it 'contains current_weather as an attribute that holds the last_updated etc info' do
      current = @attributes[:current_weather]
      
      expect(current).to be_a(Hash)

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

      expect(current).not_to have_key(:time)
      expect(current).not_to have_key(:max_temp)
      expect(current).not_to have_key(:min_temp)
    end

    it 'contains daily_weather as an attribute that is an array of the next 5 days of data' do
      daily = @attributes[:daily_weather]
      expect(daily).to be_an(Array)
      expect(daily.length).to eq(5)

      daily.each do |day|
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)

        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a(String)

        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a(String)

        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a(Float)

        expect(day).to have_key(:min_temp)
        expect(day[:min_temp]).to be_a(Float)
        
        expect(day).to have_key(:condition)
        expect(day[:condition]).to be_a(String)

        expect(day).to have_key(:icon)
        expect(day[:icon]).to be_a(String)

        expect(day).not_to have_key(:last_updated)
        expect(day).not_to have_key(:uvi)
        expect(day).not_to have_key(:conditions)
      end
    end

    it 'contains hourly_weather as an attribute that is an array of all 24 hours of hourly data for the current day' do
      hourly = @attributes[:hourly_weather]
      expect(hourly).to be_an(Array)
      expect(hourly.length).to eq(24)

      hourly.each do |hour|
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a(String)

        expect(hour).to have_key(:temperature)
        expect(hour[:temperature]).to be_a(Float)

        expect(hour).to have_key(:conditions)
        expect(hour[:conditions]).to be_a(String)

        expect(hour).to have_key(:icon)
        expect(hour[:icon]).to be_a(String)

        expect(hour).not_to have_key(:humidity)
        expect(hour).not_to have_key(:date)
        expect(hour).not_to have_key(:condition)
      end
    end
  end

end