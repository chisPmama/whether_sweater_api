class Api::V1::MunchiesController < Api::V0::ForecastsController
  def show
    restaurant = get_restaurant(find_coordinates, params[:food])
    
    binding.pry
  end
  
  private
  def get_restaurant(coordinates, type)
    conn = Faraday.new(url:"https://api.yelp.com") do |faraday|
      faraday.params["Authorization"] = Rails.application.credentials.yelp[:key]
    end
    response = conn.get("/v3/businesses/search?latitude=#{coordinates[:lat]}&longitude=#{coordinates[:lon]}term=#{type}limit=10")
    data = JSON.parse(response.body, symbolize_names: true)[:businesses]
  
    Restaurant.new(data.sample).to_hash
  end
end