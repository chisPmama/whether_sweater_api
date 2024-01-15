require "rails_helper"

RSpec.describe RestaurantFacade do 
  before :each do
    stub_yelpapi
  end

  it "can translate the city and state into lat and lon coordinates" do
    coordinates = {lat: "44.97902", lon: "-93.26494"}
    type = "italian"
    restaurant = RestaurantFacade.new.get_restaurant(coordinates, type)

    expect(restaurant).to be_a(Hash)
    expect(restaurant.keys).to eq([:name, :address, :rating, :reviews])
  end
end