require 'rails_helper'

describe CoordinateService do
  context "instance methods" do
    context "#conn" do
      it "connects" do
        service = WeatherService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "returns a hash for current_weather" do
        coordinates = "44.97902,-93.26494"
        search = WeatherService.new.find_weather(coordinates)
        expect(result.status).to eq(200)
      end
    end
  end
end