require 'rails_helper'

describe CoordinateService do
  context "instance methods" do
    context "#conn" do
      it "connects" do
        service = CoordinateService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "returns a string value of the coordinates" do
        stub_mapquest
        location = "minneapolis,mn"
        search = CoordinateService.new.find_coordinates(location)
        expect(search.status).to eq(200)
      end
    end
  end
end