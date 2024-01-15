require 'rails_helper'

RSpec.describe "Forecast", type: :request do
  before :each do
    get "/api/v0/forecast?location=minneapolis,mn"
    expect(response).to be_successful
  end

  describe "get forecast data based on the city and state inputted" do
    it 'can return a successful response that covers the first basic keys of id, type, and attributes' do
      mpls_forecast = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(mpls_forecast).to have_key(:id)
      expect(mpls_forecast).to have_key(:type)
      expect(mpls_forecast[:type]).to eq("forecast")
      expect(mpls_forecast).to have_key(:attributes)
    end

    xit 'contains current_weather as an attribute that holds the last_updated etc info' do

    end

    xit 'contains daily_weather as an attribute that is an array of the next 5 days of data' do

    end

    xit 'contains hourly_weather as an attribute that is an array of all 24 hours of hourly data for the current day' do

    end
  end

end