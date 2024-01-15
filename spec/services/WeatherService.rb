require 'rails_helper'

describe WeatherService do
  context "instance methods" do
    context "#conn" do
      it "connects" do
        service = CoordinateService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "returns a string value of the coordinates", :vcr do
        location = "minneapolis,mn"
        search = CoordinateService.new .find_coordinates(location)
        expect(search.first).to be_a String
      end
    end
  end
end