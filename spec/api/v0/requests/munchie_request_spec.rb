require 'rails_helper'

RSpec.describe "Munchie", type: :request do
  before :each do
    stub_mapquest
    stub_weatherapi

    get "/api/v1/munchies?destination=minneapolis,mn&food=italian"
    expect(response).to be_successful
    @munchie = JSON.parse(response.body, symbolize_names: true)[:data]
    @attributes = @munchie[:attributes]
  end

  describe "get forecast data based on the city and state inputted" do
    it 'can return a successful response that covers the first basic keys of id, type, and attributes' do
      expect(@munchie).to have_key(:id)
      expect(@munchie).to have_key(:type)
      expect(@munchie[:type]).to eq("munchie")
      expect(@munchie).to have_key(:attributes)
    end

    it "has three attributes of daily, hourly, and current weather" do
      expect(@attributes).to have_key(:destination_city)
      expect(@attributes).to have_key(:forecast)
      expect(@attributes).to have_key(:restaurant)
    end

    it 'contains destination as an attribute that holds the last_updated etc info' do
      destination = @attributes[:destination_city]
      
      expect(destination).to be_a(String)
      expect(destination).to eq("Minneapolis, MN")
    end

    it 'contains forecast as an attribute that holds summary and temperature' do
      forecast = @attributes[:forecast]
      
      expect(forecast).to be_a(Hash)

      expect(forecast).to have_key(:summary)
      expect(forecast[:summary]).to be_a(String)
      # expect(forecast[:summary]).to eq("Minneapolis, MN")

      expect(forecast).to have_key(:temperature)
      expect(forecast[:temperature]).to be_a(String)
      # expect(forecast[:temperature]).to eq("Minneapolis, MN")
    end

    it 'contains restaurant as an attribute that serves the specified type of cuisine and etc' do
      restaurant = @attributes[:forecast]
      
      expect(restaurant).to be_a(Hash)

      expect(restaurant).to have_key(:name)
      expect(restaurant[:name]).to be_a(String)
      # expect(restaurant[:name]).to eq("Minneapolis, MN")

      expect(restaurant).to have_key(:address)
      expect(restaurant[:address]).to be_a(String)
      # expect(restaurant[:address]).to eq("Minneapolis, MN")

      expect(restaurant).to have_key(:rating)
      expect(restaurant[:rating]).to be_a(Float)
      # expect(restaurant[:rating]).to eq("Minneapolis, MN")

      expect(restaurant).to have_key(:reviews)
      expect(restaurant[:reviews]).to be_a(Integer)
      # expect(restaurant[:rating]).to eq("Minneapolis, MN")
    end
  end
end