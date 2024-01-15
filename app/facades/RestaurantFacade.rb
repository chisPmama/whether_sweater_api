class RestaurantFacade
	def get_restaurant(coordinates, type)
		@service = RestaurantService.new
		@restaurant = json_to_h(@service.find_restaurant(coordinates, type.downcase))
	end

	def json_to_h(data)
    data = JSON.parse(data.body, symbolize_names: true)[:businesses]
    Restaurant.new(data.sample).to_hash
	end
end