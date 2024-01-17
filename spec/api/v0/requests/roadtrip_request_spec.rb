require 'rails_helper'

RSpec.describe "Road Trip request", type: :request do
  
  describe "JSON Road Trip Return with travel information" do
    before :each do
      instantiate_chisP
      login_chisP
      stub_directions
      stub_elp_coordinates
      stub_elp_forecast

      road_trip_params = {
                          "origin": "Minneapolis,MN",
                          "destination": "ElPaso,TX",
                          "api_key": @chisP.api_key
                          }
  
      post "/api/v0/road_trip", params: road_trip_params
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      @result = JSON.parse(response.body, symbolize_names: true)[:data]
      @attributes = @result[:attributes]
    end

    describe "get roadtrip information on the two locations" do
      it 'can return a successful response that covers the first basic keys of id, type, and attributes' do
        expect(@result).to have_key(:id)
        expect(@result).to have_key(:type)
        expect(@result[:type]).to eq("road_trip")
        expect(@result).to have_key(:attributes)
      end

      it 'attributes contain specfic keys regarding roadtrip' do
        expect(@attributes).to have_key(:start_city)
        expect(@attributes[:start_city]).to be_a(String)
        expect(@attributes[:start_city]).to eq("Minneapolis, MN")
  
        expect(@attributes).to have_key(:end_city)
        expect(@attributes[:end_city]).to be_a(String)
        expect(@attributes[:end_city]).to eq("El Paso, TX")
  
        expect(@attributes).to have_key(:travel_time)
        expect(@attributes[:travel_time]).to be_a(String)
        expect(@attributes[:travel_time]).to eq("20:03:03")

        expect(@attributes).to have_key(:weather_at_eta)
        expect(@attributes[:weather_at_eta]).to be_a(Hash)
      end

      it 'weather_at_eta has specific information at the time of arrival' do
        @attributes = @attributes[:weather_at_eta]
        expect(@attributes).to have_key(:datetime)
        expect(@attributes[:datetime]).to be_a(String)
        expect(@attributes[:datetime]).to eq("2024-01-17 23:22")
  
        expect(@attributes).to have_key(:temperature)
        expect(@attributes[:temperature]).to be_a(Float)
        expect(@attributes[:temperature]).to eq(57.0)
  
        expect(@attributes).to have_key(:condition)
        expect(@attributes[:condition]).to be_a(String)
        expect(@attributes[:condition]).to eq("Clear")
      end
    end
  end

end