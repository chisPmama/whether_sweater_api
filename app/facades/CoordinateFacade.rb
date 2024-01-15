class CoordinateFacade
	def get_coordinates(location)
		@service = CoordinateService.new
		@coordinates = json_to_s(@service.find_coordinates(location))
	end

	def json_to_s(data)
    data = JSON.parse(data.body, symbolize_names: true)[:results].first[:locations].first[:latLng]
    data.map{|k,v| v.to_s}.join(",")
	end
end