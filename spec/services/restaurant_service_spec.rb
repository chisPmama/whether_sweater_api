require 'rails_helper'

describe RestaurantService do
  context "instance methods" do
    context "#conn" do
      before :each do
        stub_yelpapi
      end

      it "connects" do
        service = RestaurantService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "has a successful connection" do
        coordinates = {lat: "44.97902", lon: "-93.26494"}
        type = "italian"
        search = RestaurantService.new.find_restaurant(coordinates, type)
        expect(search.status).to eq(200)
      end
    end
  end
end