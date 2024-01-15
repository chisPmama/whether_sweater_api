class CoordinateService
	def conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.mapquest[:key]
    end
	end
	
	def find_coordinates(location)
    conn.get("/geocoding/v1/address?location=#{location}")
	end
end
