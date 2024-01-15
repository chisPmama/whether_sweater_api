class WeatherService
	def conn
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.weatherapi[:key]
    end
	end
	
	def find_weather(coordinates)
    conn.get("/v1/forecast.json?q=#{coordinates}&days=5")
	end
end
