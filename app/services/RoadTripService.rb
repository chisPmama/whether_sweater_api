class RoadTripService
	def conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.mapquest[:key]
    end
	end
	
	def find_directions(origin, destination)
    raw_data =  {
                  "locations": [
                                origin,
                                destination
                              ]
                }
    json_string = JSON.generate(raw_data)
    headers = { 'Content-Type' => 'application/json' }
    response = conn.post("/directions/v2/route", json_string, headers)
	end
end
