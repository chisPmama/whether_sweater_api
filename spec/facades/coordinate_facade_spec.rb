require "rails_helper"

RSpec.describe CoordinateFacade do 
  before :each do
    stub_mapquest
  end

  it "can translate the city and state into lat and lon coordinates" do
    location = "minneapolis,mn"
    coordinates = CoordinateFacade.new.get_coordinates(location)

    expect(coordinates).to be_a(String)
    expect(coordinates).to eq("44.97902,-93.26494")
  end
end