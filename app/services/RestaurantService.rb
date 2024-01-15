class RestaurantService
	def conn
    conn = Faraday.new(url:"https://api.yelp.com") do |faraday|
      faraday.params["Authorization"] = Rails.application.credentials.yelp[:key]
    end
	end
	
	def find_restaurant(coordinates, type)
    response = conn.get("/v3/businesses/search?latitude=#{coordinates[:lat]}&longitude=#{coordinates[:lon]}term=#{type}limit=10")
	end
end
